// include uniforms


struct VertexInput {
	@location(0) position: vec3<f32>,
	@location(1) normal: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct VertexOutput {
	@builtin(position) clip_position: vec4<f32>,
	@location(0) normal: vec3<f32>,
	@location(1) worldPos: vec3<f32>,
	@location(2) uv: vec2<f32>,
};

struct MaterialUniforms {
	color: vec4<f32>,
};
@group(3) @binding(0) var<uniform> material: MaterialUniforms;

// fn gridTextureGradBox( p:vec2<f32>, lineWidth:f32) -> f32 {
// 	var ddx = dpdx(p);
// 	var ddy = dpdy(p);
// 	// filter kernel
// 	var w:vec2<f32> = max(abs(ddx), abs(ddy)) + 0.01;

// 	// analytic (box) filtering
// 	var a:vec2<f32> = p + 0.5*w;
// 	var b:vec2<f32> = p - 0.5*w;
// 	var i:vec2<f32> = (
// 		floor(a) +
// 		min(
// 			fract(a) / lineWidth,
// 			1.0
// 		) -
// 		floor(b) -
// 		min(
// 			fract(b) / lineWidth,
// 			1.0
// 		)
// 	) / ( w / lineWidth );
// 	//pattern
// 	return (1.0-i.x)*(1.0-i.y);
// }


fn grid( p:vec2<f32>, lineWidth:f32 ) -> f32 {
	// coordinates
	var i:vec2<f32> = step( fract(p), vec2(1.0*lineWidth) );
	//pattern
	return (1.0-i.x)*(1.0-i.y);   // grid (N=10)

	// other possible patterns are these
	//return 1.0-i.x*i.y;           // squares (N=4)
	//return 1.0-i.x-i.y+2.0*i.x*i.y; // checker (N=2)
}

@vertex
fn vertex(model: VertexInput) -> VertexOutput {
	var out: VertexOutput;
	out.clip_position = vec4<f32>(model.position.xy, 0.99, 1.0);
	// Calculate world position by transforming clip space position back to world space
	var ndc = vec4<f32>(model.position.xy, 0.99, 1.0);
	var viewSpace = camera.projectionMatrixInverse * ndc;
	viewSpace = viewSpace / viewSpace.w;
	// var worldSpace = /*camera.inverseView **/ viewSpace;
	var worldSpace = viewSpace + camera.worldPos;
	
	// out.worldPos.x = 0.5 / out.clip_position.x;
	// out.worldPos.y = 0.5 / out.clip_position.y;

	out.worldPos = worldSpace.xyz;
	return out;
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
	var g = grid(in.worldPos.xy, 0.05);
	// var g = gridTextureGradBox(in.worldPos.xy, 0.02);
	var bg :vec3<f32> = vec3(0.1, 0.1, 0.1);
	var fg :vec3<f32> = vec3(0.11, 0.11, 0.11);
	var col = g * bg + (1.0 - g) * fg;
	return vec4<f32>(col, 1.0);
}
