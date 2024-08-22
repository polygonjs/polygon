import { defineConfig, PluginOption, Plugin, ViteDevServer } from "vite";
import { visualizer } from "rollup-plugin-visualizer";
import checker from "vite-plugin-checker";
import { exec, ExecException, spawn, SpawnOptions } from "child_process";
// import * as fs from "fs";
// import * as path from "path";

const BUILD_ON_FILE_CHANGE: boolean = false;
const RUN_NATIVE_ON_FILE_CHANGE: boolean = false;
// const CMD_JAI = "jai";
// const CMD_JAI_ARGS = ["src/jai/build.jai"];
const CMD_BUILD = "jai src/jai/build.jai";

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
		logRedBg(`Error compiling .jai files: ${stderr}`);
		server.ws.send({
			type: "custom",
			event: "jai-wasm-error",
			data: {
				message: stderr,
			},
		});
		// exec(`xmessage -center '${stderr}' -timeout 4`);
	} else {
		if (RUN_NATIVE_ON_FILE_CHANGE) {
			logGreenBg(`+++ Compiled .jai files: ${stdout}`);
			console.log(`-----------------------------------------`);
			console.log(`--------------- Running app`);
			console.log(`-----------------------------------------`);
			exec(`bin/polygon-next-native`, (err, stdout, stderr) =>
				onRun(server, err, stdout, stderr)
			);
		} else {
			logGreenBg(
				`native app compilation succesful, but vite config is set to not run it`
			);
		}

		server.ws.send({
			type: "custom",
			event: "jai-wasm-update",
		});
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
//

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
	},
});

