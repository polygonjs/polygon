
Vector2Int :: struct {
	x: s32;
	y: s32;
}
lastPointer: Vector2Int;

orbit_controls_process_event :: (orbit_controls:*OrbitControls){
	using orbit_controls;

	x: float;
	y: float;
	left_button_down:bool;
	imguiGetMouseData(*x, *y, *left_button_down);
	if(left_button_down){
		dx:int = cast(int)x - lastPointer.x;
		dy:int = cast(int)y - lastPointer.y;
		
		theta += dx * sensitivity;
		phi -= dy * sensitivity;

		lastPointer.x = xx x;
		lastPointer.y = xx y;
	}else{
		lastPointer.x = xx x;
		lastPointer.y = xx y;
	}
}



