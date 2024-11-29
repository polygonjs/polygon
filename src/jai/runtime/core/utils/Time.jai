FrameCount :: u64;


#if WASM {
	computeFPS :: (nodesScene:*NodesScene, current_time:u64) {
		seconds_delta := current_time - previous_second_at;
		if(seconds_delta >= 1000) {
			nodesScene.fps = nodesScene.framesCount - previous_frame_count;
			previous_second_at = current_time;
			previous_frame_count = nodesScene.framesCount;
		}
	}
} else {
	computeFPS :: (nodesScene:*NodesScene, current_time:Apollo_Time) {
		seconds_delta := to_seconds(current_time - previous_second_at);
		if(seconds_delta >= 1) {
			nodesScene.fps = nodesScene.framesCount - previous_frame_count;
			previous_second_at = current_time;
			previous_frame_count = nodesScene.framesCount;
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