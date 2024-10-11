@group(0) @binding(0) var<storage, read_write> freq: vec3<f32>;
@group(0) @binding(1) var<storage, read_write> offset: vec3<f32>;
@group(0) @binding(2) var<storage, read_write> amount: vec3<f32>;
@group(1) @binding(0) var<storage, read_write> position_in: array<f32>;
@group(1) @binding(1) var<storage, read_write> normal_in: array<f32>;
@group(1) @binding(2) var<storage, read_write> position_out: array<f32>;

const stride: u32 = 3;

@compute
@workgroup_size(__WORK_GROUP_SIZE_X__, __WORK_GROUP_SIZE_Y__, __WORK_GROUP_SIZE_Z__)
fn noise(@builtin(global_invocation_id) global_id: vec3<u32>) {
	let index = global_id.x;
	if (index < arrayLength(&position_in)) {
		vec3_add_noise(stride * index);
	}
}

fn vec3_add_noise(index: u32) {
	let noise_value = perlin_noise(
		(position_in[index + 0] + offset.x) * freq.x,
		(position_in[index + 1] + offset.y) * freq.y,
		(position_in[index + 2] + offset.z) * freq.z
	);
	position_out[index + 0] = position_in[index + 0] + normal_in[index + 0] * noise_value * amount.x;
	position_out[index + 1] = position_in[index + 1] + normal_in[index + 1] * noise_value * amount.y;
	position_out[index + 2] = position_in[index + 2] + normal_in[index + 2] * noise_value * amount.z;
}

fn perlin_noise(posX: f32, posY: f32, posZ: f32) -> f32 {
	let floorX = i32(floor(posX));
	let floorY = i32(floor(posY));
	let floorZ = i32(floor(posZ));

	let X = u32(floorX & 255);
	let Y = u32(floorY & 255);
	let Z = u32(floorZ & 255);

	let x = posX - f32(floorX);
	let y = posY - f32(floorY);
	let z = posZ - f32(floorZ);
	let xMinus1 = x - 1.0;
	let yMinus1 = y - 1.0;
	let zMinus1 = z - 1.0;

	let u = fade(x);
	let v = fade(y);
	let w = fade(z);

	let A = p[X] + Y;
	let AA = p[A] + Z;
	let AB = p[A + 1u] + Z;
	let B = p[X + 1u] + Y;
	let BA = p[B] + Z;
	let BB = p[B + 1u] + Z;

	return lerp(w,
		lerp(v,
			lerp(u, grad(p[AA], x, y, z),
				grad(p[BA], xMinus1, y, z)),
			lerp(u, grad(p[AB], x, yMinus1, z),
				grad(p[BB], xMinus1, yMinus1, z))),
		lerp(v,
			lerp(u, grad(p[AA + 1u], x, y, zMinus1),
				grad(p[BA + 1u], xMinus1, y, zMinus1)),
			lerp(u, grad(p[AB + 1u], x, yMinus1, zMinus1),
				grad(p[BB + 1u], xMinus1, yMinus1, zMinus1))));
}

fn fade(t: f32) -> f32 {
	return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

fn lerp(t: f32, a: f32, b: f32) -> f32 {
	return a + t * (b - a);
}

fn grad(hash: u32, x: f32, y: f32, z: f32) -> f32 {
	let h = hash & 15u;
	let u = select(y, x, h < 8u);
	let v = select(select(z, x, h == 12u || h == 14u), y, h < 4u);
	return select(u, -u, (h & 1u) == 0u) + select(v, -v, (h & 2u) == 0u);
}

const P_SIZE: u32 = 512;

// Permutation table
var<private> p: array<u32, P_SIZE> = array<u32, P_SIZE>(
151u, 160u, 137u, 91u, 90u, 15u, 131u, 13u, 201u, 95u, 96u, 53u, 194u, 233u, 7u, 225u, 140u, 36u, 103u, 30u, 69u, 142u, 8u, 99u, 37u, 240u, 21u, 10u,
23u, 190u, 6u, 148u, 247u, 120u, 234u, 75u, 0u, 26u, 197u, 62u, 94u, 252u, 219u, 203u, 117u, 35u, 11u, 32u, 57u, 177u, 33u, 88u, 237u, 149u, 56u, 87u,
174u, 20u, 125u, 136u, 171u, 168u, 68u, 175u, 74u, 165u, 71u, 134u, 139u, 48u, 27u, 166u, 77u, 146u, 158u, 231u, 83u, 111u, 229u, 122u, 60u, 211u,
133u, 230u, 220u, 105u, 92u, 41u, 55u, 46u, 245u, 40u, 244u, 102u, 143u, 54u, 65u, 25u, 63u, 161u, 1u, 216u, 80u, 73u, 209u, 76u, 132u, 187u, 208u,
89u, 18u, 169u, 200u, 196u, 135u, 130u, 116u, 188u, 159u, 86u, 164u, 100u, 109u, 198u, 173u, 186u, 3u, 64u, 52u, 217u, 226u, 250u, 124u, 123u, 5u,
202u, 38u, 147u, 118u, 126u, 255u, 82u, 85u, 212u, 207u, 206u, 59u, 227u, 47u, 16u, 58u, 17u, 182u, 189u, 28u, 42u, 223u, 183u, 170u, 213u, 119u,
248u, 152u, 2u, 44u, 154u, 163u, 70u, 221u, 153u, 101u, 155u, 167u, 43u, 172u, 9u, 129u, 22u, 39u, 253u, 19u, 98u, 108u, 110u, 79u, 113u, 224u, 232u,
178u, 185u, 112u, 104u, 218u, 246u, 97u, 228u, 251u, 34u, 242u, 193u, 238u, 210u, 144u, 12u, 191u, 179u, 162u, 241u, 81u, 51u, 145u, 235u, 249u,
14u, 239u, 107u, 49u, 192u, 214u, 31u, 181u, 199u, 106u, 157u, 184u, 84u, 204u, 176u, 115u, 121u, 50u, 45u, 127u, 4u, 150u, 254u, 138u, 236u, 205u,
93u, 222u, 114u, 67u, 29u, 24u, 72u, 243u, 141u, 128u, 195u, 78u, 66u, 215u, 61u, 156u, 180u,
	// ... (include all 256 values, then repeat them)
151u, 160u, 137u, 91u, 90u, 15u, 131u, 13u, 201u, 95u, 96u, 53u, 194u, 233u, 7u, 225u, 140u, 36u, 103u, 30u, 69u, 142u, 8u, 99u, 37u, 240u, 21u, 10u,
23u, 190u, 6u, 148u, 247u, 120u, 234u, 75u, 0u, 26u, 197u, 62u, 94u, 252u, 219u, 203u, 117u, 35u, 11u, 32u, 57u, 177u, 33u, 88u, 237u, 149u, 56u, 87u,
174u, 20u, 125u, 136u, 171u, 168u, 68u, 175u, 74u, 165u, 71u, 134u, 139u, 48u, 27u, 166u, 77u, 146u, 158u, 231u, 83u, 111u, 229u, 122u, 60u, 211u,
133u, 230u, 220u, 105u, 92u, 41u, 55u, 46u, 245u, 40u, 244u, 102u, 143u, 54u, 65u, 25u, 63u, 161u, 1u, 216u, 80u, 73u, 209u, 76u, 132u, 187u, 208u,
89u, 18u, 169u, 200u, 196u, 135u, 130u, 116u, 188u, 159u, 86u, 164u, 100u, 109u, 198u, 173u, 186u, 3u, 64u, 52u, 217u, 226u, 250u, 124u, 123u, 5u,
202u, 38u, 147u, 118u, 126u, 255u, 82u, 85u, 212u, 207u, 206u, 59u, 227u, 47u, 16u, 58u, 17u, 182u, 189u, 28u, 42u, 223u, 183u, 170u, 213u, 119u,
248u, 152u, 2u, 44u, 154u, 163u, 70u, 221u, 153u, 101u, 155u, 167u, 43u, 172u, 9u, 129u, 22u, 39u, 253u, 19u, 98u, 108u, 110u, 79u, 113u, 224u, 232u,
178u, 185u, 112u, 104u, 218u, 246u, 97u, 228u, 251u, 34u, 242u, 193u, 238u, 210u, 144u, 12u, 191u, 179u, 162u, 241u, 81u, 51u, 145u, 235u, 249u,
14u, 239u, 107u, 49u, 192u, 214u, 31u, 181u, 199u, 106u, 157u, 184u, 84u, 204u, 176u, 115u, 121u, 50u, 45u, 127u, 4u, 150u, 254u, 138u, 236u, 205u,
93u, 222u, 114u, 67u, 29u, 24u, 72u, 243u, 141u, 128u, 195u, 78u, 66u, 215u, 61u, 156u, 180u,
);