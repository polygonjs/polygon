import { setBoolean, setFLOAT32, setU32, setU8 } from "./Common";

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
interface MouseButtons {
	left: boolean;
	middle: boolean;
	right: boolean;
}
interface EventsData {
	cursor: { x: number; y: number };
	mouseButton: MouseButtons;
	mouseButtonPressed: MouseButtons;
	wheel: number;
	textCharCodes: number[];
	modifiers: {
		alt: boolean;
		ctrl: boolean;
		meta: boolean;
		shift: boolean;
	};
	keys: boolean[];
	readPixelValue: Int8Array;
}
export const EVENTS_DATA: EventsData = {
	cursor: { x: 0, y: 0 },
	mouseButton: {
		left: false,
		middle: false,
		right: false,
	},
	mouseButtonPressed: {
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
	readPixelValue: new Int8Array(4),
};

export function addEvents(canvas: HTMLCanvasElement) {
	function onPointerdown(event: PointerEvent) {
		if (event.altKey) EVENTS_DATA.modifiers.alt = true;
		if (event.ctrlKey) EVENTS_DATA.modifiers.ctrl = true;
		if (event.metaKey) EVENTS_DATA.modifiers.meta = true;
		if (event.shiftKey) EVENTS_DATA.modifiers.shift = true;
		if (event.button === 0) {
			EVENTS_DATA.mouseButton.left = true;
			EVENTS_DATA.mouseButtonPressed.left = true;
		}
		if (event.button === 1) {
			EVENTS_DATA.mouseButton.middle = true;
			EVENTS_DATA.mouseButtonPressed.middle = true;
		}
		if (event.button === 2) {
			EVENTS_DATA.mouseButton.right = true;
			EVENTS_DATA.mouseButtonPressed.right = true;
		}
	}
	function onPointermove(event: PointerEvent) {
		// console.log(event.clientX, event.clientY)
		EVENTS_DATA.cursor.x = Math.round(event.clientX);
		EVENTS_DATA.cursor.y = Math.round(event.clientY);
	}
	function onPointerup(event: PointerEvent) {
		if (event.altKey) EVENTS_DATA.modifiers.alt = false;
		if (event.ctrlKey) EVENTS_DATA.modifiers.ctrl = false;
		if (event.metaKey) EVENTS_DATA.modifiers.meta = false;
		if (event.shiftKey) EVENTS_DATA.modifiers.shift = false;
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
		if (event.altKey) EVENTS_DATA.modifiers.alt = true;
		if (event.ctrlKey) EVENTS_DATA.modifiers.ctrl = true;
		if (event.metaKey) EVENTS_DATA.modifiers.meta = true;
		if (event.shiftKey) EVENTS_DATA.modifiers.shift = true;
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
		if (event.altKey) EVENTS_DATA.modifiers.alt = false;
		if (event.ctrlKey) EVENTS_DATA.modifiers.ctrl = false;
		if (event.metaKey) EVENTS_DATA.modifiers.meta = false;
		if (event.shiftKey) EVENTS_DATA.modifiers.shift = false;
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
	EVENTS_DATA.mouseButtonPressed.left = false;
	EVENTS_DATA.mouseButtonPressed.middle = false;
	EVENTS_DATA.mouseButtonPressed.right = false;
	// EVENTS_DATA.modifiers.alt = false;
	// EVENTS_DATA.modifiers.ctrl = false;
	// EVENTS_DATA.modifiers.meta = false;
	// EVENTS_DATA.modifiers.shift = false;
	// EVENTS_DATA.keys.fill(false);
}

export function eventsDataUpdate(
	windowWidthPointer: bigint,
	windowHeightPointer: bigint,
	mxPointer: bigint,
	myPointer: bigint,
	lmbPointer: bigint,
	mmbPointer: bigint,
	rmbPointer: bigint,
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
	keysPointer: bigint,
	// readPixelValue
	readPixelValuePointer: bigint
) {
	// window
	setU32(Number(windowWidthPointer), window.WebGPUCanvas.width);
	setU32(Number(windowHeightPointer), window.WebGPUCanvas.height);

	// mouse
	setU32(Number(mxPointer), EVENTS_DATA.cursor.x);
	setU32(Number(myPointer), EVENTS_DATA.cursor.y);
	setBoolean(Number(lmbPointer), EVENTS_DATA.mouseButton.left);
	setBoolean(Number(mmbPointer), EVENTS_DATA.mouseButton.middle);
	setBoolean(Number(rmbPointer), EVENTS_DATA.mouseButton.right);
	setBoolean(Number(lmbPressedPointer), EVENTS_DATA.mouseButtonPressed.left);
	setBoolean(
		Number(mmbPressedPointer),
		EVENTS_DATA.mouseButtonPressed.middle
	);
	setBoolean(Number(rmbPressedPointer), EVENTS_DATA.mouseButtonPressed.right);
	// wheel
	const wheel = EVENTS_DATA.wheel == 0 ? 0 : EVENTS_DATA.wheel > 0 ? -1 : 1;
	setFLOAT32(Number(wheelPointer), wheel);

	let j = 0;
	const texSize = Math.min(textDataSize, EVENTS_DATA.textCharCodes.length);
	for (let i = BigInt(0); i < texSize; i++) {
		setU8(Number(textDataPointer + i), EVENTS_DATA.textCharCodes[j]);
		j++;
	}

	// modifiers
	setBoolean(Number(altPointer), EVENTS_DATA.modifiers.alt);
	setBoolean(Number(ctrlPointer), EVENTS_DATA.modifiers.ctrl);
	setBoolean(Number(metaPointer), EVENTS_DATA.modifiers.meta);
	setBoolean(Number(shiftPointer), EVENTS_DATA.modifiers.shift);
	// keys
	for (let i = BigInt(0); i < KEYS_COUNT; i++) {
		setBoolean(Number(keysPointer + i), EVENTS_DATA.keys[Number(i)]);
	}
	// readPixelValue
	setU8(Number(readPixelValuePointer), EVENTS_DATA.readPixelValue[0]);
	setU8(Number(readPixelValuePointer) + 1, EVENTS_DATA.readPixelValue[1]);
	setU8(Number(readPixelValuePointer) + 2, EVENTS_DATA.readPixelValue[2]);
	setU8(Number(readPixelValuePointer) + 3, EVENTS_DATA.readPixelValue[3]);
}

export function eventsSetCursor(cursor: number) {
	const pointerStyle = CURSOR_STYLE_BY_CURSOR_NAME[CURSORS[cursor]];
	window.WebGPUCanvas.style.cursor = pointerStyle;
}

export function performance_now(): bigint {
	return BigInt(Math.floor(performance.now()));
}

