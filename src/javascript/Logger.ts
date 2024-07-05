export function logBlue(message: string) {
	console.log("%c" + message, "color:blue; font-weight:bold;");
}
export function logRedBg(message: string) {
	logStyled(message, {
		backgroundColor: "red",
		color: "white",
		fontWeight: "bold",
		padding: { x: 10, y: 5 },
	});
}
export function logGreenBg(message: string) {
	logStyled(message, {
		backgroundColor: "green",
		color: "white",
		fontWeight: "bold",
		padding: { x: 10, y: 5 },
	});
}
export function logBlueBg(message: string) {
	logStyled(message, {
		backgroundColor: "blue",
		color: "white",
		fontWeight: "bold",
		padding: { x: 10, y: 5 },
	});
}
export interface LogStyle {
	backgroundColor?: string;
	color?: string;
	fontWeight?: string;
	padding?: {
		x?: number;
		y?: number;
	};
}
export function logStyled(message: string, style: LogStyle) {
	const styleString = Object.entries(style)
		.map(([key, value]) => {
			const propName = key.replace(
				/([A-Z])/g,
				(g) => `-${g[0].toLowerCase()}`
			);
			if (key == "padding") {
				const padding = value as { x?: number; y?: number };
				return `padding: ${padding.y || 0}px ${padding.x || 0}px`;
			} else {
				return `${propName}: ${value}`;
			}
		})
		.join("; ");
	console.log("%c" + message, styleString);
}
export function logDefault(message: string) {
	console.log(message);
}
