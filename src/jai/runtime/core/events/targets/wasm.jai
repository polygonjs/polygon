
eventsDataUpdate :: (eventsData :*EventsData){
	eventsDataReset(eventsData);
	eventsDataUpdate(
		*(eventsData.windowSize.w),
		*(eventsData.windowSize.h),
		*(eventsData.cursor.x),
		*(eventsData.cursor.y),
		*(eventsData.prevCursor.x),
		*(eventsData.prevCursor.y),
		*(eventsData.mouseButton.left),
		*(eventsData.mouseButton.middle),
		*(eventsData.mouseButton.right),
		*(eventsData.mouseButtonJustPressed.left),
		*(eventsData.mouseButtonJustPressed.middle),
		*(eventsData.mouseButtonJustPressed.right),
		*(eventsData.mouseButtonJustReleased.left),
		*(eventsData.mouseButtonJustReleased.middle),
		*(eventsData.mouseButtonJustReleased.right),
		*(eventsData.wheel),
		eventsData.text.data,
		eventsData.text.count,
		*(eventsData.modifiers.alt),
		*(eventsData.modifiers.ctrl),
		*(eventsData.modifiers.meta),
		*(eventsData.modifiers.shift),
		eventsData.keys.data,
		*eventsData.readPixelValue,
		*(eventsData.dirty)
	);
}

eventsDataUpdate :: (
	ww:*u32, wh:*u32,
	mx: *u32, my: *u32,
	px: *u32, py: *u32,
	lmb: *bool, mmb: *bool, rmb: *bool,
	lmbJustpressed: *bool, mmbJustPressed: *bool, rmbJustPressed: *bool,
	lmbJustReleased: *bool, mmbJustReleased: *bool, rmbJustReleased: *bool,
	wheel: *float,
	text: *s8,
	text_size: u32,
	alt: *bool,
	ctrl: *bool,
	meta: *bool,
	shift: *bool,
	keys: *bool,
	readPixelValue: *READ_PIXEL_RESULT,
	dirty: *bool
) -> void #foreign;

eventsSetCursor :: (cursor:u32)->void #foreign;

performance_now :: ()->u64 #foreign;
current_time_monotonic :: ()->u64 #foreign;
to_float64_seconds :: (t:u64)->u64 #foreign;

fetchUrl :: (nodeId:NodeId, url: string) {
	fetchUrl(nodeId, url.data, url.count);
}

fetchUrl :: (nodeId:NodeId, data: *u8, size: s64) #foreign;

onAllocateReady :: (nodeId:NodeId, data: *u8, size: u64) #foreign;
onReallocReady :: (data: s64) #foreign;
// debugImageDataPng :: (data: *u8, dataSize: s32) #foreign;
loadImageDataPng :: (pngData: *u8, dataSize: s32, rawDataDest: *u8) #foreign;
loadFontData :: (pngData: *u8, dataSize: s32, rawDataDest: *u8) #foreign;

#if FOR_THREE {
	onThreeReportUpdated :: (data: *u8) #foreign;
}