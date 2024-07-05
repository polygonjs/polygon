export type SetTimeFunction = (time: number) => void;

declare global {
	interface Window {
		set_time: SetTimeFunction;
	}
}

export interface Allocated {
	buffer: Iterable<number>;
}
