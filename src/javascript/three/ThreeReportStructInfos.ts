// Auto-generated struct information for WebGPU bindings

import { GetArrayFunction, getU8, getU64 } from "../Common";
import { WASM_DATA_SIZE } from "../wasm/WasmDataSize";

export interface MemberInfo {
	size: bigint;
	offset: bigint;
	arrayView: GetArrayFunction;
}

export interface StructInfo<T extends string> {
	size: bigint;
	members: Record<T, MemberInfo>;
}

export const NodesSceneThreeReportBufferItem: StructInfo<"start" | "size"> = {
	size: 16n,
	members: {
		start: { size: WASM_DATA_SIZE.u64, offset: 0n, arrayView: getU64 },
		size: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
	},
};

export const NodesSceneThreeReportObjectItem: StructInfo<
	"position" | "normal" | "index"
> = {
	size: 48n,
	members: {
		position: {
			size: NodesSceneThreeReportBufferItem.size,
			offset: 0n,
			arrayView: getU8,
		},
		normal: {
			size: NodesSceneThreeReportBufferItem.size,
			offset: 16n,
			arrayView: getU8,
		},
		index: {
			size: NodesSceneThreeReportBufferItem.size,
			offset: 32n,
			arrayView: getU8,
		},
	},
};

export const NodesSceneThreeReport: StructInfo<"objectsCount" | "objects"> = {
	size: 16n,
	members: {
		objectsCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		objects: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
	},
};

