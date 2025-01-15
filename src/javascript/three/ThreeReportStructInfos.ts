// Auto-generated struct information for WebGPU bindings

import { GetArrayFunction, getU64 } from "../Common";
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

export const NodesSceneThreeReport: StructInfo<"objectsCount" | "buffers"> = {
	size: 16n,
	members: {
		objectsCount: {
			size: WASM_DATA_SIZE.u64,
			offset: 0n,
			arrayView: getU64,
		},
		buffers: { size: WASM_DATA_SIZE.u64, offset: 8n, arrayView: getU64 },
	},
};

