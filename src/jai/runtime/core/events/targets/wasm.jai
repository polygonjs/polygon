
events_data_update :: (events_data :*EventsData){
	eventsDataUpdate(
		*(events_data.windowSize.w),
		*(events_data.windowSize.h),
		*(events_data.cursor.x),
		*(events_data.cursor.y),
		*(events_data.mouseButton.left),
		*(events_data.mouseButton.middle),
		*(events_data.mouseButton.right),
		*(events_data.mouseButtonPressed.left),
		*(events_data.mouseButtonPressed.middle),
		*(events_data.mouseButtonPressed.right),
		*(events_data.wheel),
		events_data.text.data,
		events_data.text.count,
		*(events_data.modifiers.alt),
		*(events_data.modifiers.ctrl),
		*(events_data.modifiers.meta),
		*(events_data.modifiers.shift),
		events_data.keys.data
	);
}

eventsDataUpdate :: (ww:*u32, wh:*u32, mx: *u32, my: *u32, lmb: *bool, mmb: *bool, rmb: *bool,lmb_pressed: *bool, mmb_pressed: *bool, rmb_pressed: *bool, wheel: *float, text: *s8, text_size: u32, alt: *bool, ctrl: *bool, meta: *bool, shift: *bool, keys: *bool) -> void #foreign;
eventsSetCursor :: (cursor:u32)->void #foreign;

performance_now :: ()->u64 #foreign;