export interface ClockData {
	time: number;
	delta: number;
	previousTime: number;
}
function clockCreate(): ClockData {
	return {
		time: 0,
		delta: 0,
		previousTime: 0,
	};
}

export function clockInit() {
	const clockData = clockCreate();
	clockData.previousTime = performance.now();
	clockData.time = 0;
	clockData.delta = 0;
	return clockData;
}

export function clockTick(clockData: ClockData) {
	const now = performance.now();
	clockData.delta = Math.floor(now - clockData.previousTime);
	clockData.time += clockData.delta;
	clockData.previousTime = now;
}
