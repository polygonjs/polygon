// include uniforms

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


struct MaterialUniforms {
	offset: vec4<f32>,
};
@group(3) @binding(0) var<uniform> material: MaterialUniforms;

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
const NORMALS_BIAS:f32 = 0.01;
const EPS_V2:vec2<f32> = vec2(NORMALS_BIAS, 0.);

fn checkers(p:vec2<f32>)->f32 {
	var s = sign( fract(p*.5) - 0.5 );
	return .5 - .5*s.x*s.y;
}
// float checkersGrad( in vec2 p, in vec2 ddx, in vec2 ddy )
// {
//     // filter kernel
//     vec2 w = max(abs(ddx), abs(ddy)) + 0.01;
//     // analytical integral (box filter)
//     vec2 i = 2.0*(abs(fract((p-0.5*w)/2.0)-0.5)-abs(fract((p+0.5*w)/2.0)-0.5))/w;
//     // xor pattern
//     return 0.5 - 0.5*i.x*i.y;
// }

fn SDFSmoothUnion( d1: f32, d2:f32, k:f32 )->f32 {
	var h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
	return mix( d2, d1, h ) - k*h*(1.0-h);
}
fn sdPlane( p:vec3<f32>, n:vec3<f32>, h:f32 )->f32
{
	// n must be normalized
	return dot( p, n ) + h;
}
fn sdSphere( p: vec3<f32>, s: f32 )->f32
{
	return length(p)-s;
}

fn GetDist(p:vec3<f32>) -> SDFContext {
	var sdfContext = SDFContext(0.);

	// start GetDist builder body code



	// /geo1/MAT/rayMarchingBuilder1/SDFSphere3
	var sphere1 = sdSphere(p - (vec3(-0.25, 0.0, 0.0)+material.offset.xyz), 0.2);
	var sphere2 = sdSphere(p - vec3( 0.25, 0.2*sin(scene.time.x), 0.0), 0.2);
	var plane1 = sdPlane(p-vec3(0.0, -0.2, 0.0), vec3(0.0, 1.0, 0.0), 0.0);
	
	// /geo1/MAT/rayMarchingBuilder1/SDFContext1
	var v_POLY_SDFContext1_SDFContext = SDFContext(
		SDFSmoothUnion(
			SDFSmoothUnion(sphere1, sphere2, 0.3),
			plane1,
			0.3
		)
	);
	
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

fn applyMaterial(p:vec3<f32>, n:vec3<f32>, rayDir:vec3<f32>) -> vec3<f32>{

	// var col:vec3<f32> = vec3(0.);
	// start applyMaterial builder body code



	// /geo1/MAT/rayMarchingBuilder1/constant2
	var v_POLY_constant2_val:vec3<f32> = vec3(0.04091519690055698, 0.19806931954941637, 0.5271151256969157);
	
	// /geo1/MAT/rayMarchingBuilder1/constant3
	var v_POLY_constant3_val:vec3<f32> = vec3(0.3049873140591091, 0.4452011945063733, 0.623960391667596);
	
	// /geo1/MAT/rayMarchingBuilder1/globals2
	// vec3 v_POLY_globals2_position = p;
	
	// /geo1/MAT/rayMarchingBuilder1/vec3ToFloat1
	// float v_POLY_vec3ToFloat1_x = v_POLY_globals2_position.x;
	// float v_POLY_vec3ToFloat1_z = v_POLY_globals2_position.z;
	
	// /geo1/MAT/rayMarchingBuilder1/floatToVec2_1
	// vec2 v_POLY_floatToVec2_1_vec2 = vec2(v_POLY_vec3ToFloat1_x, v_POLY_vec3ToFloat1_z);
	
	// /geo1/MAT/rayMarchingBuilder1/checkers1
	var v_POLY_checkers1_coord = p.xz;//v_POLY_floatToVec2_1_vec2*vec2(1.0, 1.0)*1.8;
	var v_POLY_checkers1_checker = checkers(v_POLY_checkers1_coord);//, dFdx(v_POLY_checkers1_coord), dFdy(v_POLY_checkers1_coord));
	
	// /geo1/MAT/rayMarchingBuilder1/mix1
	var v_POLY_mix1_mix = mix(v_POLY_constant2_val, v_POLY_constant3_val, v_POLY_checkers1_checker);
	
	// /geo1/MAT/rayMarchingBuilder1/SDFMaterial1
	// if(mat == _GEO1_MAT_RAYMARCHINGBUILDER1_SDFMATERIAL1){
		var col:vec3<f32> = vec3(0.);
		var diffuse = v_POLY_mix1_mix;// * vec3(1.0, 1.0, 1.0) * GetLight(p, n, sdfContext);
		col += diffuse;
		// col += vec3(0.0, 0.0, 0.0);
	// }



	
	return col;
}

fn GetNormal(p:vec3<f32>)->vec3<f32> {
	var sdfContext = GetDist(p);

	var n = sdfContext.d - vec3(
		GetDist(p-EPS_V2.xyy).d,
		GetDist(p-EPS_V2.yxy).d,
		GetDist(p-EPS_V2.yyx).d);

	return normalize(n);
}

fn applyShading( rayOrigin:vec3<f32>, rayDir:vec3<f32>,   sdfContext:SDFContext)->vec4<f32>{
	var p = rayOrigin + rayDir * sdfContext.d;
	var n = GetNormal(p);
	
	var col = applyMaterial(p, n, rayDir);//, sdfContext.matId, sdfContext);
	// if(sdfContext.matBlend > 0.) {
	// 	// blend material colors if needed
	// 	vec3 col2 = applyMaterial(p, n, rayDir, sdfContext.matId2, sdfContext);
	// 	col = (1. - sdfContext.matBlend)*col + sdfContext.matBlend*col2;
	// }
		
	// gamma
	//col = pow( col, vec3(0.4545) ); // this gamma leads to a different look than standard materials
	return vec4(col, 1.);
}






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
		return applyShading(rayOrigin, rayDir, sdfContext);//vec4(1.0);//applyShading(rayOrigin, rayDir, sdfContext);
		
	} else {
		return vec4(0.0);
	}
}
