import { Vector2, Vector3 } from "./Common";
import { SceneData } from "./SceneData";

export interface OrbitControls {
	theta: number; // Angle around the Y-axis
	phi: number; // Angle around the X-axis
	radius: number; // Distance from the target
	target: Vector3; // Target point the camera looks at
	sensitivity: number;
}
export function orbitControlsCreate(): OrbitControls {
	return {
		theta: 0,
		phi: 0,
		radius: 1,
		target: { x: 0, y: 0, z: 0 },
		sensitivity: 0.01,
	};
}

export function orbitControlsFromBuffer(sceneData: SceneData) {
	const buffer = sceneData.orbitControlsBuffer;
	const orbitControls = sceneData.orbitControls;
	orbitControls.theta = buffer[0];
	orbitControls.phi = buffer[1];
	orbitControls.radius = buffer[2];
	orbitControls.target = { x: buffer[3], y: buffer[4], z: buffer[5] };
	orbitControls.sensitivity = buffer[6];
}
export function orbitControlsToBuffer(sceneData: SceneData) {
	const buffer = sceneData.orbitControlsBuffer;
	const orbitControls = sceneData.orbitControls;
	buffer[0] = orbitControls.theta;
	buffer[1] = orbitControls.phi;
	buffer[2] = orbitControls.radius;
	buffer[3] = orbitControls.target.x;
	buffer[4] = orbitControls.target.y;
	buffer[5] = orbitControls.target.z;
	buffer[6] = orbitControls.sensitivity;
}
let leftMouseButtonDown: boolean = false;
const lastPointer: Vector2 = { x: 0, y: 0 };
export function orbitControlsAddEvents(
	domElement: HTMLElement,
	sceneData: SceneData
) {
	const orbitControls = sceneData.orbitControls;
	function onPointerdown(event: PointerEvent) {
		if (event.button == 0) {
			document.addEventListener("pointerup", onPointerup);
			document.addEventListener("pointermove", onPointermove);
			leftMouseButtonDown = true;
			lastPointer.x = event.clientX;
			lastPointer.y = event.clientY;
		}
	}
	function onPointerup(event: PointerEvent) {
		if (event.button == 0) {
			leftMouseButtonDown = false;
			document.removeEventListener("pointerup", onPointerup);
			document.removeEventListener("pointermove", onPointermove);
		}
	}
	function onPointermove(event: PointerEvent) {
		if (!leftMouseButtonDown) {
			return;
		}
		const dx = event.clientX - lastPointer.x;
		const dy = event.clientY - lastPointer.y;
		orbitControls.theta += dx * orbitControls.sensitivity;
		orbitControls.phi -= dy * orbitControls.sensitivity;
		lastPointer.x = event.clientX;
		lastPointer.y = event.clientY;

		orbitControlsToBuffer(sceneData);
	}
	function onMousewheel(event: WheelEvent) {
		orbitControls.radius += event.deltaY * 0.01;
		if (orbitControls.radius < 1.0) orbitControls.radius = 1.0;
		orbitControlsToBuffer(sceneData);
	}
	domElement.addEventListener("pointerdown", onPointerdown);
	domElement.addEventListener("wheel", onMousewheel);
}
