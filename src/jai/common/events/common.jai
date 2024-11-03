EventsDataWindowSize :: struct {
	w: u32;
	h: u32;
};
EventsDataCursor :: struct {
	x: u32;
	y: u32;
};
ViewportRect :: struct {
	start: Vector2;
	size: Vector2;
}
ViewportContainer :: struct {
	full_screen:bool;
	viewport:ViewportRect;
}
EventsDataMouseButtons :: struct {
	left: bool;
	middle: bool;
	right: bool;
};
EventsDataModifiers :: struct {
	alt: bool;
	ctrl: bool;
	meta: bool;
	shift: bool;
};
TEXTINPUTEVENT_TEXT_SIZE :: 32; // sams as SDL_TEXTINPUTEVENT_TEXT_SIZE
KEYS_MAX::524;//666;
KEYS_START::511;
KEYS_COUNT::KEYS_MAX-KEYS_START;
KEYS_INIT:[KEYS_COUNT]bool;
EventsData :: struct {
	windowSize :EventsDataWindowSize;
	cursor :EventsDataCursor;
	mouseButton :EventsDataMouseButtons;
	mouseButtonPressed :EventsDataMouseButtons;
	wheel :float;
	text: [TEXTINPUTEVENT_TEXT_SIZE] s8;
	modifiers: EventsDataModifiers;
	keys: [KEYS_COUNT]bool;
};

events_data_reset :: (events_data :*EventsData){
	using events_data;
	wheel = 0;
	modifiers = .{};
	mouseButtonPressed.left = false;
	mouseButtonPressed.middle = false;
	mouseButtonPressed.right = false;

	// events_data.modifiers.alt = false;
	// events_data.modifiers.ctrl = false;
	// events_data.modifiers.shift = false;
	// events_data.modifiers.meta = false;
	memcpy(events_data.keys.data, KEYS_INIT.data, KEYS_COUNT);
}
EMPTY_TEXT :[TEXTINPUTEVENT_TEXT_SIZE] s8;
events_data_clear_text :: (events_data :*EventsData){
	memcpy(events_data.text.data, EMPTY_TEXT.data, TEXTINPUTEVENT_TEXT_SIZE);
}