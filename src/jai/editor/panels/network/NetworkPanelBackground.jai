networkPanelAddBgMesh :: (panel:*TYPE, scene:*Scene, color:Color) {
	mat := newMaterial(scene, MATERIAL_BG);
	setColor(mat, color);
	mesh0 := newMesh(scene, Mesh);
	assert(mesh0.geometry != null, "mesh0.geometry is null\n");
	mesh0.material = xx mat;
	geometry_plane_update(mesh0.geometry, size=.{2,2}, segments=.{1,1});
	transformable_update_matrix(mesh0);
	sceneObjectAdd(scene, mesh0);
}

#scope_file

TYPE :: NetworkPanel;
MATERIAL_BG :: BackgroundMeshMaterial;