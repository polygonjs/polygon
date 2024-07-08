OrbitControls :: struct {
	theta:float  = 0.0; // Angle around the Y-axis
	phi:float  = 0.0;  // Angle around the X-axis
	radius:float  = 5.0; // Distance from the target
	target :Vector3 = .{x=0.0,y=0.0,z=0.0}; // Target point the camera looks at
	sensitivity: float = 0.0025;
	//
	leftMouseButtonDown:bool  = false;
	lastMouseX: int;
	lastMouseY: int;
}

PHI_MIN :: -PI/2;
PHI_MAX :: +PI/2;

orbit_controls_process_event :: (orbit_controls:*OrbitControls, event :*SDL_Event){
	using orbit_controls;
	if event.type == {
		case SDL_MOUSEBUTTONDOWN; {
			if (event.button.button == SDL_BUTTON_LEFT) {
				leftMouseButtonDown = true;
				lastMouseX = event.button.x;
				lastMouseY = event.button.y;
			}
		}
		case SDL_MOUSEBUTTONUP; {
			if (event.button.button == SDL_BUTTON_LEFT) {
				leftMouseButtonDown = false;
			}
		}
		case SDL_MOUSEMOTION; {
			if (leftMouseButtonDown) {
				dx:int = event.motion.x - lastMouseX;
				dy:int = event.motion.y - orbit_controls.lastMouseY;
				
				theta += dx * sensitivity;
				phi -= dy * sensitivity;

				// Clamp phi to avoid flipping at the poles
				if (phi < PHI_MIN) phi = PHI_MIN;
				if (phi > PHI_MAX) phi = PHI_MAX;

				lastMouseX = event.motion.x;
				lastMouseY = event.motion.y;
			}
		}
		case SDL_MOUSEWHEEL; {
			radius -= event.wheel.y * 0.1;
			if (radius < 1.0) radius = 1.0; // Prevent radius from being too small
		}
	}
}

AXIS_X	::Vector3.{x=1.0, y=0.0, z=0.0};
AXIS_Y	::Vector3.{x=0.0, y=1.0, z=0.0};
UP		::Vector3.{x=0.0, y=1.0, z=0.0};

orbit_controls_update_camera:: (orbit_controls: *OrbitControls, camera_data: *CameraData){
	using orbit_controls;

	// quaternions
	quaternionX :Quaternion;
	quaternionY :Quaternion;
	set_from_axis_and_angle(*quaternionY, AXIS_Y, -theta);
	set_from_axis_and_angle(*quaternionX, AXIS_X, phi);
	
	// rotate + translate
	transformMatrix :Matrix4;
	identity(*transformMatrix);
	transformMatrix = rotate(transformMatrix, quaternionY);
	transformMatrix = rotate(transformMatrix, quaternionX);
	translate(*transformMatrix, .{x=0.0, y=0.0, z=radius});
	camera_data.transformMatrix = transformMatrix;
}