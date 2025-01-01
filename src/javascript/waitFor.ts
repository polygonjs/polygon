interface WaitForConditionOptions {
	timeoutMs?: number;
	label?: string;
}
export async function waitForCondition(
	callback: () => boolean,
	options: WaitForConditionOptions = {}
): Promise<void> {
	const timeoutMs = options.timeoutMs ?? 5000;
	const label = options.label ?? "no label";
	return new Promise((resolve) => {
		const startTime = performance.now();
		const interval = setInterval(() => {
			if (callback()) {
				clearInterval(interval);
				resolve();
			} else {
				if (performance.now() - startTime > timeoutMs) {
					clearInterval(interval);
					console.error(`waitForCondition timeout: "${label}"`);
					resolve();
				}
			}
		}, 100);
	});
}
