networkPanelAddBgMesh :: (panel:*TYPE, scene:*Scene, color:Color) {
	mat := newMaterial(scene, MATERIAL_BG);
	setColor(mat, color);
	mesh := newMesh(scene, Mesh);
	assert(mesh.geometry != null, "mesh0.geometry is null\n");
	meshSetMaterial(scene, mesh, xx mat);
	geometryPlaneAttributesSet(mesh.geometry, .{size=.{2,2}, segments=.{1,1}});
	transformableUpdateMatrix(mesh);
	sceneObjectAdd(scene, mesh);
}

#scope_file

TYPE :: NetworkPanel;
MATERIAL_BG :: MeshBackgroundGridMaterial;