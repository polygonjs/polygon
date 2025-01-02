Raycaster :: struct {
	ray: Ray;
}

raycasterSetFromCamera :: (raycaster: *Raycaster, camera: *$T, coords: Vector2) {
	generatedCameraSetRaycaster(camera, raycaster, coords);
}

