import { Scene, PerspectiveCamera, GridHelper, WebGLRenderer } from "three";
// @ts-ignore
import { OrbitControls } from "three/addons/controls/OrbitControls";
// @ts-ignore
import Stats from "three/addons/libs/stats.module.js";
import { USELESS_ARG0 } from "../Common";
import { clockInit, clockTick } from "../Clock";

export interface ThreeController {
	start: () => void;
	stop: () => void;
}
export function threeControllerCreate(): ThreeController {
	const domElement = document.getElementById("app") as HTMLElement;
	const stats = new Stats();
	domElement.appendChild(stats.dom);

	const renderer = new WebGLRenderer({ antialias: true });
	const canvas = renderer.domElement;
	domElement.appendChild(canvas);

	const scene = new Scene();

	const camera = new PerspectiveCamera(
		40,
		window.innerWidth / window.innerHeight,
		1,
		100
	);
	camera.position.set(0, 1, 4);

	const controls = new OrbitControls(camera, renderer.domElement);
	controls.target.set(0, 0.5, 0);
	controls.update();
	controls.enableDamping = true;

	const gridHelper = new GridHelper();
	scene.add(gridHelper);

	function onResize() {
		camera.aspect = window.innerWidth / window.innerHeight;
		camera.updateProjectionMatrix();

		renderer.setSize(window.innerWidth, window.innerHeight);
	}

	window.onresize = onResize;
	onResize();

	const clockData = clockInit();
	function animate() {
		// const delta = clock.getDelta();

		// mixer.update( delta );

		clockTick(clockData);
		window.wasmFunctions.onRequestAnimationFrame(
			USELESS_ARG0,
			BigInt(clockData.time),
			BigInt(canvas.width),
			BigInt(canvas.height)
		);

		controls.update();

		stats.update();

		renderer.render(scene, camera);
	}
	function start() {
		renderer.setAnimationLoop(animate);
	}
	function stop() {
		console.warn("threeController.stop() not implemented yet");
	}
	return {
		start,
		stop,
	};
}

