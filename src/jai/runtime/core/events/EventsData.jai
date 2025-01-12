EventsDataWindowSize :: struct {
	w: u32;
	h: u32;
};
EventsDataCursor :: Vector2UInt;
ViewportRect :: struct {
	start: Vector2UInt64;
	size: Vector2UInt64;
}
ViewportContainer :: struct {
	fullScreen:bool;
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
	prevCursor :EventsDataCursor;
	mouseButton :EventsDataMouseButtons;
	mouseButtonJustPressed :EventsDataMouseButtons;
	mouseButtonJustReleased :EventsDataMouseButtons;
	wheel :float;
	text: [TEXTINPUTEVENT_TEXT_SIZE] s8;
	modifiers: EventsDataModifiers;
	keys: [KEYS_COUNT]bool;
	readPixelValue: READ_PIXEL_RESULT;
	dirty: bool;
};

eventsDataReset :: (using eventsData :*EventsData){
	wheel = 0;
	mouseButtonJustPressed.left = false;
	mouseButtonJustPressed.middle = false;
	mouseButtonJustPressed.right = false;
	mouseButtonJustReleased.left = false;
	mouseButtonJustReleased.middle = false;
	mouseButtonJustReleased.right = false;
	memcpy(keys.data, KEYS_INIT.data, KEYS_COUNT);
	dirty = false;
}
EMPTY_TEXT :[TEXTINPUTEVENT_TEXT_SIZE] s8;
eventsDataClearText :: (eventsData :*EventsData){
	memcpy(eventsData.text.data, EMPTY_TEXT.data, TEXTINPUTEVENT_TEXT_SIZE);
}