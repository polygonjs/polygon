FrameCount :: u64;


#if WASM {
	compute_fps :: (scene:*NodesScene, current_time:u64, ui_data: *UiData) {
		seconds_delta := current_time - previous_second_at;
		if(seconds_delta >= 1000) {
			ui_data.fps = scene.framesCount - previous_frame_count;
			previous_second_at = current_time;
			previous_frame_count = scene.framesCount;
		}
	}
} else {
	compute_fps :: (scene:*NodesScene, current_time:Apollo_Time, ui_data: *UiData) {
		seconds_delta := to_seconds(current_time - previous_second_at);
		if(seconds_delta >= 1) {
			ui_data.fps = scene.framesCount - previous_frame_count;
			previous_second_at = current_time;
			previous_frame_count = scene.framesCount;
		}
	}
}

#scope_file

#if WASM {
	previous_second_at:u64;
} else {
	previous_second_at:Apollo_Time;
}

previous_frame_count:FrameCount;