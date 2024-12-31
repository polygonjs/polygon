pipelineControllerAddMesh :: (using pc: *PipelineController, mesh: *Mesh) {
	drawData := newDrawData(pc, mesh);
	array_add(*drawDatas, drawData);

	if mesh.use_compute {
		renderer.computes = compute_controller_collection_create(pc.renderer.wgpuContext, mesh);
		pipeline_controller_update(pc, *pc.renderer.computes);
	}
}

pipelineControllerRemoveMesh :: (using pc: *PipelineController, mesh: *Mesh) {
	found, index := pipelineControllerGetDrawData(pc, mesh);
	if found {
		array_unordered_remove_by_index(*drawDatas, index);
	}
	// drawData := newDrawData(pc, mesh);
	// array_add(*meshes, mesh);
	// array_add(*meshes_draw_data, drawData);
}