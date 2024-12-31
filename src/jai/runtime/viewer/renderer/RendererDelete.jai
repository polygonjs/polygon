rendererDestroyBuffers :: (using renderer:*Renderer){
	for container: buffersToDestroy {
		wgpuBufferDestroy(container.buffer);
	}
	buffersToDestroy.count = 0;
	// for renderer.pipelines_by_mat_type {
	// 	pipelineControllerDestroyScheduledBuffers(it);
	// }
	// multisample_release(renderer);
	// depth_release(renderer);
}
rendererReset :: (renderer:*Renderer) {
	rendererDestroyBuffers(renderer);
	allocatorReset(renderer);
}

rendererDelete :: (renderer:*Renderer) {
	rendererReset(renderer);
	free(renderer);
}