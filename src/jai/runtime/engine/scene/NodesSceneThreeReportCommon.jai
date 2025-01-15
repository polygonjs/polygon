NodesSceneThreeReportBufferItem :: struct {
	start: *void;
	size: u64;
}
NodesSceneThreeReportObjectItem :: struct {
	position: NodesSceneThreeReportBufferItem;
	normal: NodesSceneThreeReportBufferItem;
	index: NodesSceneThreeReportBufferItem;
}
NodesSceneThreeReport :: struct {
	objectsCount: u64;
	objects: *NodesSceneThreeReportObjectItem;
}
