interface EventsData {
	cursor: { x: number; y: number };
	mouseButton: {
		left: boolean;
		middle: boolean;
		right: boolean;
	};
}
export const EVENTS_DATA: EventsData = {
	cursor: { x: 0, y: 0 },
	mouseButton: {
		left: false,
		middle: false,
		right: false,
	},
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
	canvas.addEventListener("pointerdown", onPointerdown);
	canvas.addEventListener("pointermove", onPointermove);
	canvas.addEventListener("pointerup", onPointerup);
}
