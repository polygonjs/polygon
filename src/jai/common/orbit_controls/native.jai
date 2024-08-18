
leftMouseButtonDown:bool = false;
Vector2Int :: struct {
	x: s32;
	y: s32;
}
lastPointer: Vector2Int;

orbit_controls_process_event :: (orbit_controls:*OrbitControls, event :*SDL_Event){
	using orbit_controls;
	
	if event.type == {
		case SDL_MOUSEBUTTONDOWN; {
			if (event.button.button == SDL_BUTTON_LEFT) {
				leftMouseButtonDown = true;
				lastPointer.x = event.button.x;
				lastPointer.y = event.button.y;
			}
		}
		case SDL_MOUSEBUTTONUP; {
			if (event.button.button == SDL_BUTTON_LEFT) {
				leftMouseButtonDown = false;
			}
		}
		case SDL_MOUSEMOTION; {
			if (leftMouseButtonDown) {
				dx:int = event.motion.x - lastPointer.x;
				dy:int = event.motion.y - lastPointer.y;
				
				theta += dx * sensitivity;
				phi -= dy * sensitivity;

				lastPointer.x = event.motion.x;
				lastPointer.y = event.motion.y;
			}
		}
		case SDL_MOUSEWHEEL; {
			radius -= event.wheel.y * 0.1;
			if (radius < 1.0) radius = 1.0; // Prevent radius from being too small
		}
	}
}



