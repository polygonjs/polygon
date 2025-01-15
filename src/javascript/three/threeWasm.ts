import {
	// BoxGeometry,
	BufferGeometry,
	DoubleSide,
	Float32BufferAttribute,
	Mesh,
	MeshNormalMaterial,
	Scene,
	Uint32BufferAttribute,
} from "three";
import { _big, createItemsByPointer } from "../wasm/WasmUtils";
import {
	NodesSceneThreeReport,
	NodesSceneThreeReportBufferItem,
	NodesSceneThreeReportObjectItem,
} from "./ThreeReportStructInfos";

interface NodesSceneThreeReportBufferItem {
	start: number;
	size: number;
}
interface NodesSceneThreeReportObjectItem {
	position: NodesSceneThreeReportBufferItem;
	normal: NodesSceneThreeReportBufferItem;
	index: NodesSceneThreeReportBufferItem;
}
interface NodesSceneThreeReport {
	objects: NodesSceneThreeReportObjectItem[];
	meshes: Mesh[];
	scene: Scene;
}
export const POLYGON_THREE_REPORT: NodesSceneThreeReport = {
	objects: [],
	meshes: [],
	scene: new Scene(),
};
const DEFAULT_MAT = new MeshNormalMaterial();
DEFAULT_MAT.wireframe = false;
DEFAULT_MAT.side = DoubleSide;

export function onThreeReportUpdated(p: bigint) {
	const m = NodesSceneThreeReport.members;
	const objectsCount = _big(p, m.objectsCount);

	const objects = createItemsByPointer<NodesSceneThreeReportObjectItem>({
		pointer: p,
		itemsCount: objectsCount,
		itemSize: NodesSceneThreeReport.size,
		memberInfo: m.objects,
		callback: (itemPointer) => {
			return nodesSceneThreeReportObjectItemFromBuffer(itemPointer);
		},
	});

	POLYGON_THREE_REPORT.objects.length = Number(objectsCount);
	for (let i = 0; i < objectsCount; i++) {
		POLYGON_THREE_REPORT.objects[i] = objects[i];
		let mesh = POLYGON_THREE_REPORT.meshes[i];
		if (mesh == null) {
			// const geometry = new BoxGeometry(1, 1, 1);

			const geometry = new BufferGeometry();
			const positionAttribute = new Float32BufferAttribute(
				new Float32Array([]),
				3
			);
			const normalAttribute = new Float32BufferAttribute(
				new Float32Array([]),
				3
			);
			const index = new Uint32BufferAttribute(new Uint32Array(), 1);
			geometry.setAttribute("position", positionAttribute);
			geometry.setAttribute("normal", normalAttribute);
			geometry.setIndex(index);

			mesh = new Mesh(geometry, DEFAULT_MAT); // maybe use a pool here instead?
			POLYGON_THREE_REPORT.meshes[i] = mesh;
			POLYGON_THREE_REPORT.scene.add(mesh);
		}
		updateGeometry(mesh.geometry, objects[i]);
	}
}

function updateGeometry(
	geometry: BufferGeometry,
	reportObjectItem: NodesSceneThreeReportObjectItem
) {
	function updateFloat32Attribute(
		geometry: BufferGeometry,
		attributeName: string,
		reportBufferItem: NodesSceneThreeReportBufferItem,
		itemsCount: number
	) {
		const start = reportBufferItem.start;
		const size = reportBufferItem.size * itemsCount;
		const newArray = new Float32Array(
			window.ALLOCATED_MEMORY_CONTAINER.dataView.buffer,
			start,
			size
		);
		const attribute = geometry.getAttribute(attributeName)!;
		// const attribute = new Float32BufferAttribute(newArray, itemsCount);
		// geometry.setAttribute(attributeName, attribute);
		(attribute as any).array = newArray;
		// console.log(newArray);
		attribute.needsUpdate = true;
	}
	function updateIndex(
		geometry: BufferGeometry,
		reportBufferItem: NodesSceneThreeReportBufferItem,
		itemsCount: number
	) {
		const start = reportBufferItem.start;
		const size = reportBufferItem.size * itemsCount;
		const newArray = new Uint32Array(
			window.ALLOCATED_MEMORY_CONTAINER.dataView.buffer,
			start,
			size
		);
		// const attribute = geometry.getIndex()!;
		const attribute = new Uint32BufferAttribute(newArray, itemsCount);
		geometry.setIndex(attribute);
		(attribute as any).array = newArray;
		// console.log(newArray);
		attribute.needsUpdate = true;
	}
	updateFloat32Attribute(geometry, "position", reportObjectItem.position, 3);
	updateFloat32Attribute(geometry, "normal", reportObjectItem.normal, 3);
	updateIndex(geometry, reportObjectItem.index, 1);
}

function nodesSceneThreeReportObjectItemFromBuffer(
	p: bigint
): NodesSceneThreeReportObjectItem {
	const m = NodesSceneThreeReportObjectItem.members;
	const position = nodesSceneThreeReportBufferItemFromBuffer(
		p + m.position.offset
	);
	const normal = nodesSceneThreeReportBufferItemFromBuffer(
		p + m.normal.offset
	);
	const index = nodesSceneThreeReportBufferItemFromBuffer(p + m.index.offset);

	const item: NodesSceneThreeReportObjectItem = {
		position,
		normal,
		index,
	};
	// console.log(`${item.position.size}-${item.normal.size}-${item.index.size}`);
	return item;
}

function nodesSceneThreeReportBufferItemFromBuffer(
	p: bigint
): NodesSceneThreeReportBufferItem {
	const m = NodesSceneThreeReportBufferItem.members;
	const start = _big(p, m.start);
	const size = _big(p, m.size);

	const item: NodesSceneThreeReportBufferItem = {
		start: Number(start),
		size: Number(size),
	};
	return item;
}

