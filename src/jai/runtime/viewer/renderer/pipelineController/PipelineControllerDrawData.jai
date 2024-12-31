

MeshDrawData :: struct {
	mesh: *Mesh;
	vertex:[..]BufferContainer;
	index:BufferContainer;

	DrawDataDataUniform :: struct {

		DrawDataUniformData :: struct {
			bufferContainer: BufferContainer;
			bind_group_entries: []WGPUBindGroupEntry;
			bind_group: WGPUBindGroup;
		}

		object: DrawDataUniformData;
		material: DrawDataUniformData;
	}
	uniforms:DrawDataDataUniform;
}


pipelineControllerGetDrawData :: (using pc: *PipelineController, mesh: *Mesh) -> (found:bool, index:s64) {
	for drawData, i: drawDatas {
		if drawData.mesh == mesh {
			return true, i;
		}
	}
	return false, -1;
}


newDrawData :: (pc: *PipelineController, mesh: *Mesh)-> *MeshDrawData {
	renderer := pc.renderer;
	wgpuContext := renderer.wgpuContext;
	drawData :*MeshDrawData = New(MeshDrawData,, renderer.allocator);
	drawData.mesh = mesh;
	push_allocator(pc.renderer.allocator);
	array_init(*drawData.vertex);
	
	materialInitDrawData(wgpuContext, mesh, pc, drawData);

	return drawData;
}



drawDataBuffersScheduleDestroy :: (using renderer: *Renderer, drawData: *MeshDrawData) {
	for v: drawData.vertex {
		array_add(*buffersToDestroy, v);
	}
	array_add(*buffersToDestroy, drawData.index);
}

drawDataUpdateMeshUniforms :: (renderer: *Renderer, drawData: *MeshDrawData) {
	using drawData.uniforms.object.bufferContainer;
	wgpuQueueWriteBuffer(renderer.wgpuContext.queue, buffer, 0, *drawData.mesh.transformableUniforms, buffer_size);
}
