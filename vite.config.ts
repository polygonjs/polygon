import { ViteHotReloadEvent } from "./src/javascript/config/ViteHotReloadEvent";
import { defineConfig, PluginOption, Plugin, ViteDevServer } from "vite";
import { visualizer } from "rollup-plugin-visualizer";
import checker from "vite-plugin-checker";
import { exec, ExecException } from "child_process";

const BUILD_ON_FILE_CHANGE: boolean = true;
const RUN_NATIVE_ON_FILE_CHANGE: boolean = false;
interface BuildArgs {
	wasm: boolean;
	native: boolean;
	noeditor: boolean;
	three: boolean;
	test: boolean;
	//
	wasm32: boolean;
}
const BUILD_ARGS: BuildArgs = {
	wasm: true,
	native: false,
	noeditor: false,
	three: false,
	test: false,
	//
	wasm32: false,
};
const CMD_BUILD_ARGS: string[] = [];
if (BUILD_ARGS.wasm || BUILD_ARGS.wasm32) CMD_BUILD_ARGS.push("wasm");
if (BUILD_ARGS.native) CMD_BUILD_ARGS.push("native");
if (BUILD_ARGS.noeditor) CMD_BUILD_ARGS.push("noeditor");
if (BUILD_ARGS.three) CMD_BUILD_ARGS.push("three");
if (BUILD_ARGS.test) CMD_BUILD_ARGS.push("test");

const CMD_WASM64232 = "yarn wasm64232";
const CMD_JAI = `jai src/jai/build/build.jai - ${CMD_BUILD_ARGS.join(" ")}`;
const CMD_ELEMENTS = [CMD_JAI];
if (BUILD_ARGS.wasm32) {
	CMD_ELEMENTS.push(CMD_WASM64232);
}
const CMD_BUILD = CMD_ELEMENTS.join(" && ");

function logRedBg(message: string) {
	logStyled(message, {
		backgroundColor: "red",
		color: "white",
		fontWeight: "bold",
		padding: { x: 10, y: 5 },
	});
}
function logGreenBg(message: string) {
	logStyled(message, {
		backgroundColor: "green",
		color: "white",
		fontWeight: "bold",
		padding: { x: 10, y: 5 },
	});
}
function logBlueBg(message: string) {
	logStyled(message, {
		backgroundColor: "blue",
		color: "white",
		fontWeight: "bold",
		padding: { x: 10, y: 5 },
	});
}
interface LogStyle {
	backgroundColor?: string;
	color?: string;
	fontWeight?: string;
	padding?: {
		x?: number;
		y?: number;
	};
}
function logStyled(message: string, style: LogStyle) {
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
function terminalLogGreenBg(message: string) {
	console.log("\x1b[42m\x1b[30m%s\x1b[0m", message);
}
function terminalLogRedBg(message: string) {
	console.log("\x1b[41m\x1b[30m%s\x1b[0m", message);
}
const realConsoleClear = console.clear;
console.clear = () => {};

function fileIsNotInDotBuildFolder(filePath: string): boolean {
	return filePath.includes("/.build/") == false;
}
function fileHasValidExtension(filePath: string): boolean {
	return filePath.endsWith(".jai") || filePath.endsWith(".wgsl");
}
function fileIsValid(filePath: string): boolean {
	return (
		fileHasValidExtension(filePath) && fileIsNotInDotBuildFolder(filePath)
	);
}

const onBuild = (
	server: ViteDevServer,
	err: ExecException | null,
	stdout: string,
	stderr: string
) => {
	if (err) {
		console.warn(`output:`);
		console.warn(`-----------------------------------------`);
		console.log(stdout);
		console.warn(`-----------------------------------------`);
		for (let i = 0; i < 12; i++) {
			console.log("*");
		}
		logRedBg(`Error compiling .jai files: ${stderr}`);
		server.ws.send({
			type: "custom",
			event: ViteHotReloadEvent.BUILD_ERROR,
			data: {
				message: stderr,
			},
		});
		// exec(`xmessage -center '${stderr}' -timeout 4`);
	} else {
		server.ws.send({
			type: "custom",
			event: ViteHotReloadEvent.BUILD_SUCCESS,
		});
		realConsoleClear();
		console.clear = () => {};
		terminalLogGreenBg(
			`+ build successful ( ${
				RUN_NATIVE_ON_FILE_CHANGE
					? "WASM + NATIVE"
					: "WASM ONLY, do not run native"
			} )`
		);
		if (RUN_NATIVE_ON_FILE_CHANGE) {
			exec(`killall polygon-next`, () =>
				exec(`bin/polygon-next`, (err, stdout, stderr) =>
					onRun(server, err, stdout, stderr)
				)
			);
		}
	}
};
const onRun = (
	server: ViteDevServer,
	err: ExecException | null,
	stdout: string,
	stderr: string
) => {
	console.log(stdout);
	console.log(stderr);
};

function jaiPlugin() {
	const configureServer: Plugin["configureServer"] = (
		server: ViteDevServer
	) => {
		//
		server.watcher.add("src/**/*.jai");
		server.watcher.add("src/**/*.wgsl");

		server.watcher.on("change", (filePath) => {
			if (fileIsValid(filePath)) {
				if (!BUILD_ON_FILE_CHANGE) {
					console.warn(
						"config is not set to recompile for now, compile manually"
					);
					return;
				}
				console.log(`-----------------------------------------`);
				console.log(`--------------- File changed: ${filePath}`);
				console.log(`-----------------------------------------`);
				console.log(
					`--------------- Compiling .jai files (${performance.now()})`
				);
				console.log(`-----------------------------------------`);
				console.log(`${CMD_BUILD}`);
				server.ws.send({
					type: "custom",
					event: ViteHotReloadEvent.BUILD_START,
				});
				exec(
					CMD_BUILD,
					{
						shell: "/bin/bash",
						cwd: process.cwd(),
						env: { ...process.env },
					},
					(err, stdout, stderr) =>
						onBuild(server, err, stdout, stderr)
				);
				// spawn(CMD_JAI,CMD_JAI_ARGS)
			}
		});
	};

	return {
		name: "watch-jai-files",
		configureServer,
	};
}

// https://vitejs.dev/config/
export default defineConfig({
	plugins: [
		checker({
			// https://vite-plugin-checker.netlify.app/checkers/vue-tsc.html
			// vueTsc: true,
			typescript: true,
		}),
		visualizer({
			template: "treemap", // or sunburst
			open: false,
			gzipSize: true,
			brotliSize: true,
			filename: "analyse.html", // will be saved in project's root
		}) as PluginOption,
		jaiPlugin(),
	],
	server: {
		host: true,
	},
	base: "/",
	build: {
		outDir: "dist",
		rollupOptions: {
			input: {
				main: "./index.html",
				three: "./three.html",
			},
		},
	},
});

