import { defineConfig, PluginOption, Plugin, ViteDevServer } from "vite";
import { visualizer } from "rollup-plugin-visualizer";

import { exec, ExecException } from "child_process";
// import * as fs from "fs";
// import * as path from "path";

const BUILD_ON_FILE_CHANGE: boolean = true;
const RUN_NATIVE_ON_FILE_CHANGE: boolean = false;

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
		console.error(`Error compiling .jai files: ${stderr}`);
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
			console.log(`Compiled .jai files: ${stdout}`);
			console.log(`-----------------------------------------`);
			console.log(`--------------- Running app`);
			console.log(`-----------------------------------------`);
			exec(`bin/polygon-next-native`, (err, stdout, stderr) =>
				onRun(server, err, stdout, stderr)
			);
		} else {
			console.warn(`not running native app`);
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
			if (fileIsValid(filePath) && BUILD_ON_FILE_CHANGE) {
				// console.log(
				// 	"config is not set to recompile for now, compile manually"
				// );
				// return;
				console.log(`-----------------------------------------`);
				console.log(`--------------- File changed: ${filePath}`);
				console.log(`-----------------------------------------`);
				exec("jai src/jai/build.jai", (err, stdout, stderr) =>
					onBuild(server, err, stdout, stderr)
				);
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
