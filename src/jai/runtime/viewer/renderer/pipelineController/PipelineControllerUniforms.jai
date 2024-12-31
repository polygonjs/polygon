pipelineControllerUpdateUniformBuffers :: (using pc: *PipelineController, mesh:*Mesh) {
	found, index := pipelineControllerGetDrawData(pc, mesh);
	if found {
		drawData := drawDatas[index];
		drawDataUpdateMeshUniforms(pc.renderer, drawData);
	}
}

pipelineControllerUpdateRenderableUniformBuffers :: (using pc: *PipelineController) {
	
	wgpuContext := renderer.wgpuContext;
	// using the dirty flag may need a bit more work:
	// - ensure mesh uniforms trigger it
	// - ensure camera uniforms is shared and triggers it
	// - ensure material uniforms is shared and triggers it
	// if(!pc.uniforms_dirty) return;
	// defer pc.uniforms_dirty = false;
	assert(drawDatas.count > 0, "pc.drawDatas is empty");
	// assert(meshes.count == drawDatas.count, "pc.meshes.count != pc.meshes_draw_data.count");
	for drawData, i: drawDatas {
		drawDataUpdateMeshUniforms(renderer, drawData);
		// draw_data := meshes_draw_data[i];
		// {
		// 	size := cast(u64) max( 16, size_of(TransformableUniforms));
		// 	buffer := draw_data.uniforms.object.buffer;
		// 	// print("upload:%,%\n", mesh.id, mesh.position);
		// 	wgpuQueueWriteBuffer(wgpuContext.queue, buffer, 0, *mesh.transformableUniforms, size);
		// }
		// {
		// 	size := cast(u64) max( 16, size_of(CameraUniforms));
		// 	buffer := draw_data.uniforms.camera.buffer;
		// 	wgpuQueueWriteBuffer(pc.wgpuContext.queue, buffer, 0, cast(*void) *scene.orbit_controls.camera.uniforms, size);
		// }
		// {
		// 	size := cast(u64) max( 16, material.uniformTypeSize);
		// 	buffer := draw_data.uniforms.material.buffer;
		// 	wgpuQueueWriteBuffer(wgpuContext.queue, buffer, 0, *material.uniforms, size);
		// }
		// update_object_uniforms_to_buffer(pc.wgpuContext, draw_data.uniforms.object.buffer, *mesh);
		// update_camera_uniforms_to_buffer(pc.wgpuContext, draw_data.uniforms.camera.buffer, scene_data);
		// update_sdf_uniforms_to_buffer(wgpuContext, draw_data.uniforms.material.buffer, scene_data);
	}
}


pipelineControllerUpdateMaterialUniformBuffers :: (using pc: *PipelineController) {
	
	wgpuContext := renderer.wgpuContext;
	// using the dirty flag may need a bit more work:
	// - ensure mesh uniforms trigger it
	// - ensure camera uniforms is shared and triggers it
	// - ensure material uniforms is shared and triggers it
	// if(!pc.uniforms_dirty) return;
	// defer pc.uniforms_dirty = false;
	assert(drawDatas.count > 0, "pc.drawDatas is empty");
	// assert(meshes.count == meshes_draw_data.count, "pc.meshes.count != pc.meshes_draw_data.count");
	for drawData, i: drawDatas {
		// draw_data := meshes_draw_data[i];
		// {
		// 	size := cast(u64) max( 16, size_of(TransformableUniforms));
		// 	buffer := draw_data.uniforms.object.buffer;
		// 	// print("upload:%,%\n", mesh.id, mesh.position);
		// 	wgpuQueueWriteBuffer(wgpuContext.queue, buffer, 0, *mesh.transformableUniforms, size);
		// }
		// {
		// 	size := cast(u64) max( 16, size_of(CameraUniforms));
		// 	buffer := draw_data.uniforms.camera.buffer;
		// 	wgpuQueueWriteBuffer(pc.wgpuContext.queue, buffer, 0, cast(*void) *scene.orbit_controls.camera.uniforms, size);
		// }
		{
			size := cast(u64) max( 16, material.uniformTypeSize);
			buffer := drawData.uniforms.material.buffer;
			wgpuQueueWriteBuffer(wgpuContext.queue, buffer, 0, *material.uniforms, size);
		}
		// update_object_uniforms_to_buffer(pc.wgpuContext, draw_data.uniforms.object.buffer, *mesh);
		// update_camera_uniforms_to_buffer(pc.wgpuContext, draw_data.uniforms.camera.buffer, scene_data);
		// update_sdf_uniforms_to_buffer(wgpuContext, draw_data.uniforms.material.buffer, scene_data);
	}
}



