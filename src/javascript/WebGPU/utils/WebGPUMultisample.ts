export function update_render_pass_descriptor_multisample(
	use_msaa: boolean,
	_colorAttachmentPointer: bigint
) {
	if (use_msaa) {
		console.log(
			"update_render_pass_descriptor_multisample NOT IMPLEMENTED",
			use_msaa
		);
	}
}