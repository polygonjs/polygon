Raycaster :: struct {
	ray: Ray;
}

raycasterSetFromCamera :: (raycaster: *Raycaster, camera: *Camera, coords: Vector2) {
	generatedCameraSetRaycaster(camera, raycaster, coords);
}

