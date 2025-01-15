NodesSceneThreeReportBufferItem :: struct {
	start: *void;
	size: u64;
}
NodesSceneThreeReport :: struct {
	objectsCount: u64;
	buffers: *NodesSceneThreeReportBufferItem;
}
