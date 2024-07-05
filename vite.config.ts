import { defineConfig, PluginOption } from "vite";
import { visualizer } from "rollup-plugin-visualizer";

import { exec } from "child_process";
// import * as fs from "fs";
// import * as path from "path";

function jaiPlugin() {
	return {
		name: "watch-jai-files",
		configureServer(server) {
			// Watch .jai files
			server.watcher.add("src/**/*.jai");

			// Handle file changes
			server.watcher.on("change", (filePath) => {
				if (
					filePath.endsWith(".jai") == true &&
					filePath.includes("/.build/") == false
				) {
					console.log(`File changed: ${filePath}`);
					exec("jai src/jai/build.jai", (err, stdout, stderr) => {
						if (err) {
							console.error(
								`Error compiling .jai files: ${stderr}`
							);
						} else {
							console.log(`Compiled .jai files: ${stdout}`);

							// server.ws.send({
							// 	type: "full-reload",
							// 	path: "*",
							// });
							server.ws.send({
								type: "custom",
								event: "jai-wasm-update",
								// data: {
								//   path: '/public/output.wasm' // Adjust the path if necessary
								// }
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
