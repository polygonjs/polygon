
pipeline_controller_update_render_pass :: (using pc: *PipelineController, renderPassEncoder: WGPURenderPassEncoder) {
	wgpuRenderPassEncoderSetPipeline(renderPassEncoder, pipeline);

	for drawData: drawDatas {
		{
			wgpuRenderPassEncoderSetBindGroup(renderPassEncoder, xx UniformBindingIndex.SCENE, renderer.scene_data.bind_group, 0, null);
			wgpuRenderPassEncoderSetBindGroup(renderPassEncoder, xx UniformBindingIndex.CAMERA, renderer.camera_data.bind_group, 0, null);
			using drawData.uniforms;
			wgpuRenderPassEncoderSetBindGroup(renderPassEncoder, xx UniformBindingIndex.OBJECT, object.bind_group, 0, null);
			wgpuRenderPassEncoderSetBindGroup(renderPassEncoder, xx UniformBindingIndex.MATERIAL, material.bind_group, 0, null);
		}
		//
		for v, vi: drawData.vertex {
			// print("submit attribute buffer START: % % (%/%)\n", v.buffer, v.label, vi+1, draw_data.vertex.count);
			wgpuRenderPassEncoderSetVertexBuffer(renderPassEncoder, xx vi, v.buffer, 0, v.buffer_size);
		}
		wgpuRenderPassEncoderSetIndexBuffer(renderPassEncoder, drawData.index.buffer, WGPUIndexFormat.Uint32, 0, drawData.index.buffer_size);

		// mesh :*Mesh= drawData[it_index];
		#if RENDER_SCENE wgpuRenderPassEncoderDrawIndexed(renderPassEncoder, xx (drawData.mesh.geometry.indices.count), 1, 0, 0, 0);
	}
}

