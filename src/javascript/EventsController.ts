import { WGPU_SIZE } from "./WebGPU/utils/WebGPUOffset";

// TODO: an improvement would be to only write to the memory
// when an event happens.
// TODO: check that keystrokes and pointer events are still taken into account when the pointerdown and pointerup are triggered within the same frame

enum Cursor {
	Arrow = "",
	TextInput = "1",
	ResizeAll = 2,
	ResizeNS = 3,
	ResizeEW = 4,
	ResizeNESW = 5,
	ResizeNWSE = 6,
	Hand = 7,
	NotAllowed = 8,
}
const CURSORS: Cursor[] = [
	Cursor.Arrow,
	Cursor.TextInput,
	Cursor.ResizeAll,
	Cursor.ResizeNS,
	Cursor.ResizeEW,
	Cursor.ResizeNESW,
	Cursor.ResizeNWSE,
	Cursor.Hand,
	Cursor.NotAllowed,
];
const CURSOR_STYLE_BY_CURSOR_NAME: Record<Cursor, string> = {
	[Cursor.Arrow]: "auto",
	[Cursor.TextInput]: "text",
	[Cursor.ResizeAll]: "all-scroll",
	[Cursor.ResizeNS]: "ns-resize",
	[Cursor.ResizeEW]: "ew-resize",
	[Cursor.ResizeNESW]: "nesw-resize",
	[Cursor.ResizeNWSE]: "nwse-resize",
	[Cursor.Hand]: "pointer",
	[Cursor.NotAllowed]: "not-allowed",
};

enum Key {
	LeftArrow = "ArrowLeft",
	RightArrow = "ArrowRight",
	UpArrow = "ArrowUp",
	DownArrow = "ArrowDown",
	PageUp = "PageUp",
	PageDown = "PageDown",
	Home = "Home",
	End = "End",
	Delete = "Delete",
	Backspace = "Backspace",
	Enter = "Enter",
	Escape = "Escape",
}

const KEYS: Key[] = [
	Key.LeftArrow,
	Key.RightArrow,
	Key.UpArrow,
	Key.DownArrow,
	Key.PageUp,
	Key.PageDown,
	Key.Home,
	Key.End,
	Key.Delete,
	Key.Backspace,
	Key.Enter,
	Key.Escape,
];

const KEYS_COUNT = KEYS.length;
const KEY_INDEX_BY_KEY_NAME: Record<Key, number> = {
	[Key.LeftArrow]: -1,
	[Key.RightArrow]: -1,
	[Key.UpArrow]: -1,
	[Key.DownArrow]: -1,
	[Key.PageUp]: -1,
	[Key.PageDown]: -1,
	[Key.Home]: -1,
	[Key.End]: -1,
	[Key.Delete]: -1,
	[Key.Backspace]: -1,
	[Key.Enter]: -1,
	[Key.Escape]: -1,
};
for (let i = 0; i < KEYS_COUNT; i++) {
	KEY_INDEX_BY_KEY_NAME[KEYS[i]] = i;
}

interface EventsData {
	cursor: { x: number; y: number };
	mouseButton: {
		left: boolean;
		middle: boolean;
		right: boolean;
	};
	wheel: number;
	textCharCodes: number[];
	modifiers: {
		alt: boolean;
		ctrl: boolean;
		meta: boolean;
		shift: boolean;
	};
	keys: boolean[];
}
export const EVENTS_DATA: EventsData = {
	cursor: { x: 0, y: 0 },
	mouseButton: {
		left: false,
		middle: false,
		right: false,
	},
	wheel: 0,
	textCharCodes: [],
	modifiers: {
		alt: false,
		ctrl: false,
		meta: false,
		shift: false,
	},
	keys: new Array(666),
};

export function addEvents(canvas: HTMLCanvasElement) {
	function onPointerdown(event: PointerEvent) {
		if (event.button === 0) {
			EVENTS_DATA.mouseButton.left = true;
		}
		if (event.button === 1) {
			EVENTS_DATA.mouseButton.middle = true;
		}
		if (event.button === 2) {
			EVENTS_DATA.mouseButton.right = true;
		}
	}
	function onPointermove(event: PointerEvent) {
		// console.log(event.clientX, event.clientY)
		EVENTS_DATA.cursor.x = Math.round(event.clientX);
		EVENTS_DATA.cursor.y = Math.round(event.clientY);
	}
	function onPointerup(event: PointerEvent) {
		if (event.button === 0) {
			EVENTS_DATA.mouseButton.left = false;
		}
		if (event.button === 1) {
			EVENTS_DATA.mouseButton.middle = false;
		}
		if (event.button === 2) {
			EVENTS_DATA.mouseButton.right = false;
		}
	}
	function onWheel(event: WheelEvent) {
		EVENTS_DATA.wheel = event.deltaY;
	}
	function onKeydown(event: KeyboardEvent) {
		if (event.key.length > 1) {
			for (let i = 0; i < KEYS_COUNT; i++) {
				const key = KEYS[i];
				if (event.key === key) {
					EVENTS_DATA.keys[KEY_INDEX_BY_KEY_NAME[key]] = true;
				}
			}
			return;
		}
		EVENTS_DATA.textCharCodes.push(event.key.charCodeAt(0));
	}
	function onKeyup(event: KeyboardEvent) {
		if (event.altKey) EVENTS_DATA.modifiers.alt = true;
		if (event.ctrlKey) EVENTS_DATA.modifiers.ctrl = true;
		if (event.metaKey) EVENTS_DATA.modifiers.meta = true;
		if (event.shiftKey) EVENTS_DATA.modifiers.shift = true;
		if (event.key.length > 1) {
			for (let i = 0; i < KEYS_COUNT; i++) {
				const key = KEYS[i];
				if (event.key === key) {
					EVENTS_DATA.keys[KEY_INDEX_BY_KEY_NAME[key]] = false;
				}
			}
		}
	}
	canvas.addEventListener("pointerdown", onPointerdown);
	canvas.addEventListener("pointermove", onPointermove);
	canvas.addEventListener("pointerup", onPointerup);
	canvas.addEventListener("wheel", onWheel);
	canvas.addEventListener("keydown", onKeydown);
	canvas.addEventListener("keyup", onKeyup);
}
export function eventsDataReset() {
	EVENTS_DATA.wheel = 0;
	EVENTS_DATA.textCharCodes.length = 0;
	EVENTS_DATA.modifiers.alt = false;
	EVENTS_DATA.modifiers.ctrl = false;
	EVENTS_DATA.modifiers.meta = false;
	EVENTS_DATA.modifiers.shift = false;
	// EVENTS_DATA.keys.fill(false);
}

export function eventsDataUpdate(
	windowWidthPointer: bigint,
	windowHeightPointer: bigint,
	mxPointer: bigint,
	myPointer: bigint,
	lmbPressedPointer: bigint,
	mmbPressedPointer: bigint,
	rmbPressedPointer: bigint,
	wheelPointer: bigint,
	textDataPointer: bigint,
	textDataSize: number,
	// modifiers
	altPointer: bigint,
	ctrlPointer: bigint,
	metaPointer: bigint,
	shiftPointer: bigint,
	// keys
	keysPointer: bigint
) {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u8 = new Uint8Array(buffer);
	const u32 = new Uint32Array(buffer);
	const f32 = new Float32Array(buffer);

	const _setBoolean = (pointer: bigint, value: boolean) => {
		u8[Number(pointer / WGPU_SIZE.bool)] = value ? 0xff : 0;
	};
	const _setU8 = (pointer: bigint, value: number) => {
		u8[Number(pointer / WGPU_SIZE.u8)] = value;
	};
	const _setU32 = (pointer: bigint, value: number) => {
		u32[Number(pointer / WGPU_SIZE.u32)] = value;
	};
	const _setFloat32 = (pointer: bigint, value: number) => {
		f32[Number(pointer / WGPU_SIZE.float)] = value;
	};

	// window
	_setU32(windowWidthPointer, window.WebGPUCanvas.width);
	_setU32(windowHeightPointer, window.WebGPUCanvas.height);

	// mouse
	_setU32(mxPointer, EVENTS_DATA.cursor.x);
	_setU32(myPointer, EVENTS_DATA.cursor.y);
	_setBoolean(lmbPressedPointer, EVENTS_DATA.mouseButton.left);
	_setBoolean(mmbPressedPointer, EVENTS_DATA.mouseButton.middle);
	_setBoolean(rmbPressedPointer, EVENTS_DATA.mouseButton.right);
	// wheel
	const wheel = EVENTS_DATA.wheel == 0 ? 0 : EVENTS_DATA.wheel > 0 ? -1 : 1;
	_setFloat32(wheelPointer, wheel);

	let j = 0;
	const texSize = Math.min(textDataSize, EVENTS_DATA.textCharCodes.length);
	for (let i = BigInt(0); i < texSize; i++) {
		_setU8(textDataPointer + i, EVENTS_DATA.textCharCodes[j]);
		j++;
	}

	// modifiers
	_setBoolean(altPointer, EVENTS_DATA.modifiers.alt);
	_setBoolean(ctrlPointer, EVENTS_DATA.modifiers.ctrl);
	_setBoolean(metaPointer, EVENTS_DATA.modifiers.meta);
	_setBoolean(shiftPointer, EVENTS_DATA.modifiers.shift);
	// keys
	for (let i = BigInt(0); i < KEYS_COUNT; i++) {
		_setBoolean(keysPointer + i, EVENTS_DATA.keys[Number(i)]);
	}
}

export function eventsSetCursor(cursor: number) {
	const pointerStyle = CURSOR_STYLE_BY_CURSOR_NAME[CURSORS[cursor]];
	window.WebGPUCanvas.style.cursor = pointerStyle;
}

