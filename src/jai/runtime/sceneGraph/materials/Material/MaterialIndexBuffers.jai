materialInitDrawData_CreateIndexBuffer :: (wgpuContext: *WGPUContext, mesh: *Mesh, drawData: *MeshDrawData) {
	using drawData.index;
	buffer,
	buffer_size = _wgpuBufferFromGeometryIndex_Create(wgpuContext, mesh.geometry.indices);
}
materialInitDrawData_UploadIndexBuffer :: (wgpuContext: *WGPUContext, mesh: *Mesh, drawData: *MeshDrawData) {
	_wgpuBufferFromGeometryIndex_Upload(wgpuContext, mesh.geometry.indices, drawData.index);
}