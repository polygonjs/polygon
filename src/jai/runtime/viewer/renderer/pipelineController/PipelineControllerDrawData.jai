MeshDrawData :: struct {
	mesh: *Mesh;
	vertex:[..]BufferContainer;
	index:BufferContainer;
	uniforms:PipelineDataUniform;
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
	materialInitDrawDataBindGroupLayouts(wgpuContext, mesh, pc, drawData);

	return drawData;
}



drawDataBuffersScheduleDestroy :: (using renderer: *Renderer, drawData: *MeshDrawData) {
	for v: drawData.vertex {
		array_add(*buffersToDestroy, v);
	}
	array_add(*buffersToDestroy, drawData.index);
}

drawDataUpdateMeshUniforms :: (using renderer: *Renderer, drawData: *MeshDrawData) {
	size := cast(u64) max( 16, size_of(TransformableUniforms));
	buffer := drawData.uniforms.object.buffer;
	wgpuQueueWriteBuffer(wgpuContext.queue, buffer, 0, *drawData.mesh.transformableUniforms, size);
}