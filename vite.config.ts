import { defineConfig, PluginOption } from "vite";
import { visualizer } from "rollup-plugin-visualizer";

import { exec } from "child_process";
// import * as fs from "fs";
// import * as path from "path";

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

function jaiPlugin() {
	return {
		name: "watch-jai-files",
		configureServer(server) {
			//
			server.watcher.add("src/**/*.jai");
			server.watcher.add("src/**/*.wgsl");

			server.watcher.on("change", (filePath) => {
				if (fileIsValid(filePath)) {
					console.log(`-----------------------------------------`);
					console.log(`--------------- File changed: ${filePath}`);
					console.log(`-----------------------------------------`);
					exec("jai src/jai/build.jai", (err, stdout, stderr) => {
						if (err) {
							console.error(
								`Error compiling .jai files: ${stderr}`
							);
							server.ws.send({
								type: "custom",
								event: "jai-wasm-error",
								data: {
									message: stderr,
								},
							});
							// exec(`xmessage -center '${stderr}' -timeout 4`);
						} else {
							console.log(`Compiled .jai files: ${stdout}`);
							exec(`bin/polygon-next-native`);

							server.ws.send({
								type: "custom",
								event: "jai-wasm-update",
							});
						}
					});
				}
			});
		},
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
