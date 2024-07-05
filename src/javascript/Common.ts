export type SetTimeFunction = (uselessArg: BigInt, time: BigInt) => void;

declare global {
	interface Window {
		set_time: SetTimeFunction;
		offset: number;
	}
}

export interface Allocated {
	buffer: Iterable<number>;
}
