import { _big, createItemsByPointer } from "../wasm/WasmUtils";
import {
	NodesSceneThreeReport,
	NodesSceneThreeReportBufferItem,
} from "./ThreeReportStructInfos";

interface NodesSceneThreeReportBufferItem {
	start: bigint;
	size: bigint;
}
interface NodesSceneThreeReport {
	objectsCount: bigint;
	buffers: NodesSceneThreeReportBufferItem[];
}

export async function onThreeReportUpdated(p: bigint) {
	const m = NodesSceneThreeReport.members;
	const objectsCount = _big(p, m.objectsCount);

	const buffers = createItemsByPointer<NodesSceneThreeReportBufferItem>({
		pointer: p,
		itemsCount: objectsCount,
		itemSize: NodesSceneThreeReport.size,
		memberInfo: m.buffers,
		callback: (itemPointer) => {
			return nodesSceneThreeReportBufferItemFromBuffer(itemPointer);
		},
	});

	const report: NodesSceneThreeReport = {
		objectsCount,
		buffers,
	};
	console.log(report);
}

function nodesSceneThreeReportBufferItemFromBuffer(
	p: bigint
): NodesSceneThreeReportBufferItem {
	const m = NodesSceneThreeReportBufferItem.members;
	const start = _big(p, m.start);
	const size = _big(p, m.size);

	const item: NodesSceneThreeReportBufferItem = {
		start,
		size,
	};
	return item;
}

