struct VertexInput {
	@location(0) position: vec3<f32>,
	@location(1) color: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct VertexOutput {
	@builtin(position) clip_position: vec4<f32>,
	@location(0) worldPos: vec3<f32>,
	@location(1) color: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct ObjectUniforms {
	transformMatrix: mat4x4f,
};
struct CameraUniforms {
	time: vec4<f32>,
	worldPos: vec4<f32>,
	transformMatrixInverse: mat4x4f,
	projectionMatrix: mat4x4f,
};

struct SDFContext {
	d: f32,
	// stepsCount: int;
	// matId: int;
	// matId2: int;
	// matBlend: float32;
};
const MAX_STEPS:i32 = 100;
const MAX_DIST:f32 = 100.;
const SURF_DIST:f32 = 0.001;

fn SDFSmoothUnion( d1: f32, d2:f32, k:f32 )->f32 {
	var h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
	return mix( d2, d1, h ) - k*h*(1.0-h);
}
fn sdSphere( p: vec3<f32>, s: f32 )->f32
{
	return length(p)-s;
}

fn GetDist(p:vec3<f32>) -> SDFContext {
	var sdfContext = SDFContext(0.);

	// start GetDist builder body code



	// /geo1/MAT/rayMarchingBuilder1/SDFSphere3
	var v_POLY_SDFSphere1 = sdSphere(p - vec3(-0.25, 0.0, 0.0), 0.2);
	var v_POLY_SDFSphere2 = sdSphere(p - vec3( 0.25, 0.2*sin(camera.time.x), 0.0), 0.2);
	
	// /geo1/MAT/rayMarchingBuilder1/SDFContext1
	var v_POLY_SDFContext1_SDFContext = SDFContext(SDFSmoothUnion(v_POLY_SDFSphere1, v_POLY_SDFSphere2, 0.3));
	
	// /geo1/MAT/rayMarchingBuilder1/output1
	sdfContext = v_POLY_SDFContext1_SDFContext;



	

	return sdfContext;
}

fn RayMarch(ro: vec3<f32> ,  rd:vec3<f32>,  side:bool)->SDFContext {
	var dO = SDFContext(0.);

	for(var i:i32=0; i<MAX_STEPS; i++) {
		var p = ro + rd*dO.d;
		var sdfContext = GetDist(p);
		dO.d += sdfContext.d;// * (side ? 1. : -1.);
		// #if defined( DEBUG_STEPS_COUNT )
		// 	dO.stepsCount += 1;
		// #endif
		// dO.matId = sdfContext.matId;
		// dO.matId2 = sdfContext.matId2;
		// dO.matBlend = sdfContext.matBlend;
		if(dO.d>MAX_DIST || abs(sdfContext.d)<SURF_DIST){ break; }
	}

	return dO;
}

@group(0) @binding(0) var<uniform> object: ObjectUniforms;
@group(1) @binding(0) var<uniform> camera: CameraUniforms;



@vertex
fn vertex(model: VertexInput) -> VertexOutput {
	var out: VertexOutput;
	var mvPosition = vec4<f32>(model.position, 1.0);
	// out.clip_position = vec4<f32>(model.position, 1.0) * (object.transformMatrix);
	// out.clip_position = out.clip_position * camera.transformMatrixInverse;
	// out.clip_position = camera.projectionMatrix * out.clip_position;

	// out.clip_position = out.clip_position * (camera.projectionMatrix * camera.transformMatrixInverse);

	// out.clip_position = camera.projectionMatrix * ((vec4<f32>(model.position, 1.0) * (object.transformMatrix)) * cameraUniforms.transformMatrixInverse);

	var modelViewMatrix = camera.transformMatrixInverse * object.transformMatrix;
	var finalMatrix = camera.projectionMatrix * modelViewMatrix;
	out.clip_position = finalMatrix * mvPosition;

	out.worldPos = (object.transformMatrix * mvPosition).xyz;
	out.color = model.color;
	out.uv = model.uv;
	return out;
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
	// return vec4<f32>(in.uv.x, in.uv.y, 0.0, 1.0);
	// return vec4<f32>(in.color, 1.0);
	// return vec4<f32>(abs(in.worldPos - camera.worldPos.xyz), 1.0);

	var rayOrigin = camera.worldPos.xyz;
	var rayDir = normalize(in.worldPos - camera.worldPos.xyz);
	var sdfContext = RayMarch(rayOrigin, rayDir, true);

	if( sdfContext.d < MAX_DIST ){
		return vec4(1.0);//applyShading(rayOrigin, rayDir, sdfContext);
		
	} else {
		return vec4(0.5);
	}
}
