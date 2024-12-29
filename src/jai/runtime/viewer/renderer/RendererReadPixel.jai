
READ_PIXEL_TEXTURE_DESC := WGPUTextureDescriptor.{
	size = .{
		width = 0,
		height = 0,
		depthOrArrayLayers = 1
	},
};
READ_PIXEL_TEXTURE_VIEW_DESCRIPTOR :: WGPUTextureViewDescriptor.{
	label = "readPixel_texture_view_descriptor",
	mipLevelCount = 1,
	arrayLayerCount = 1,
};
READ_PIXEL_BUFFER_DESC :: WGPUBufferDescriptor.{
	size = READ_PIXEL_BUFFER_SIZE,  // RGBA8 = 4 bytes
	usage = xx (WGPUBufferUsage.CopyDst | WGPUBufferUsage.MapRead),
	mappedAtCreation = xx false,
};
createPixelReadbackResources :: (renderer: *Renderer)->bool {

	device := renderer.wgpuContext.device;

	assert(renderer.wgpuContext.preferred_texture_format != WGPUTextureFormat.Undefined, "preferred_texture_format is undefined");
	assert(cast(*void)renderer.wgpuContext.preferred_texture_format != null, "preferred_texture_format is null");

	rtSize := rendererTargetSize(renderer);
	if rtSize.x<=1 || rtSize.y<=1 {
		return false;
	}

	if (READ_PIXEL_TEXTURE_DESC.size.width==rtSize.x && READ_PIXEL_TEXTURE_DESC.size.height==rtSize.y) {
		return true;
	}

	{
		using READ_PIXEL_TEXTURE_DESC;
		size.width = xx rtSize.x;
		size.height = xx rtSize.y;
		format = rendererFormat(renderer);//.RGBA32Uint; // renderer.wgpuContext.preferred_texture_format;
		usage = xx (WGPUTextureUsage.RenderAttachment | WGPUTextureUsage.CopySrc);
		dimension = WGPUTextureDimension._2D;
		mipLevelCount = 1;
		sampleCount = 1;
	}
	renderer.readback_texture = wgpuDeviceCreateTexture(device, *READ_PIXEL_TEXTURE_DESC);
	renderer.readback_view = wgpuTextureCreateView(renderer.readback_texture, *READ_PIXEL_TEXTURE_VIEW_DESCRIPTOR);
	renderer.readback_buffer = wgpuDeviceCreateBuffer(device, *READ_PIXEL_BUFFER_DESC);
	return true;
}
renderPixel :: (renderer: *Renderer, scene: *Scene, camera: *Camera, pos:Vector2UInt) {
	if WAITING_FOR_BUFFER_MAPPED_STATE == true {
		return;
	}
	if renderer.useReadback {
		creationSuccess := createPixelReadbackResources(renderer);
		if !creationSuccess {
			return;
		}
	}
	rendererPreRender(renderer, camera);

	// create_multi_sample_texture_if_needed( renderer );
	create_depth_texture_if_needed( renderer );
	device := renderer.wgpuContext.device;
	colorAttachment := WGPURenderPassColorAttachment.{
		view = renderer.readback_view,
		loadOp = ifx renderer.clear then WGPULoadOp.Clear else WGPULoadOp.Load,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_color_create(renderer.bgColor),
	};

	cmd_encoder := wgpuDeviceCreateCommandEncoder(
		device,
		*(WGPUCommandEncoderDescriptor.{label = "Pixel Readback Encoder"}),
	);
	defer wgpuCommandEncoderRelease(cmd_encoder);

	// Set up a render pass that renders just the pixel you want
	render_pass_descriptor := WGPURenderPassDescriptor.{
		label = "Pixel Readback Pass",
		colorAttachmentCount = 1,
		colorAttachments = *colorAttachment,
	};
	update_render_pass_descriptor_depth(renderer, *render_pass_descriptor);

	render_pass_encoder := wgpuCommandEncoderBeginRenderPass(cmd_encoder, *render_pass_descriptor);
	defer wgpuRenderPassEncoderRelease(render_pass_encoder);

	scissor_pos :Vector2UInt = .{
		x = xx (pos.x-renderer.viewport.start.x),
		y = xx (pos.y-renderer.viewport.start.y),
	};
	{
		using renderer.viewport;
		// set_viewport(render_pass_encoder, xx 0, xx 0, xx size.x, xx size.y);
		set_scissor_rect(render_pass_encoder, scissor_pos.x, scissor_pos.y, 1, 1);
	}
	
	renderer_scene_uniform_buffer_update(renderer, scene, scene.sceneUniforms);
	for renderer.pipelines_by_mat_type pipeline_controller_update_render_pass(it, render_pass_encoder);

	wgpuRenderPassEncoderEnd(render_pass_encoder);

	copy_texture := WGPUImageCopyTexture.{
		texture = renderer.readback_texture,
		mipLevel = 0,
		origin = .{
			x = scissor_pos.x,
			y = scissor_pos.y,
			z = 0
		},
	};

	copy_buffer := WGPUImageCopyBuffer.{
		buffer = renderer.readback_buffer,
		layout = .{
			offset = 0,
			bytesPerRow = READ_PIXEL_BUFFER_SIZE,
			rowsPerImage = 1,
		},
	};

	copy_size := WGPUExtent3D.{width = 1, height = 1, depthOrArrayLayers = 1};
	wgpuCommandEncoderCopyTextureToBuffer(cmd_encoder, *copy_texture, *copy_buffer, *copy_size);

	cmdBufferDesc := WGPUCommandBufferDescriptor.{label = "read pixel encoder"};
	cmd_buffer := wgpuCommandEncoderFinish(cmd_encoder, *cmdBufferDesc);
	wgpuQueueSubmit(renderer.wgpuContext.queue, 1, *cmd_buffer);

	wgpuBufferMapAsync(renderer.readback_buffer, xx WGPUMapMode.Read, 0, READ_DATA_SIZE, wgpu_render_pixel_async_callback, renderer);
	WAITING_FOR_BUFFER_MAPPED_STATE = true;
	// wgpuDevicePoll(device, xx true, null);

	// data := cast(*READ_PIXEL_RESULT)wgpuBufferGetMappedRange(renderer.readback_buffer, 0, READ_DATA_SIZE);
	// result := data.*;

	// wgpuBufferUnmap(renderer.readback_buffer);
	// return result;
}
readPixelIfMapped :: (renderer: *Renderer, eventsData: *EventsData) -> (buffer_ready:bool, result:READ_PIXEL_RESULT) {
	if WAITING_FOR_BUFFER_MAPPED_STATE == false {
		return false, .[0,0,0,0];
	}
	device := renderer.wgpuContext.device;

	#if WASM {
		if wgpuBufferGetMapState(renderer.readback_buffer) == .Mapped {
			// data := cast(*READ_PIXEL_RESULT)wgpuBufferGetMappedRange(renderer.readback_buffer, 0, READ_DATA_SIZE);
			wgpuBufferGetMappedRange(renderer.readback_buffer, 0, READ_DATA_SIZE);
			wgpuBufferUnmap(renderer.readback_buffer);
			WAITING_FOR_BUFFER_MAPPED_STATE = false;
			eventsDataUpdate(eventsData); // TODO: it would be preferrable to only request the readPixelValue and not all other events data.
			return true, eventsData.readPixelValue;
		}
		return false, .[0,0,0,0];
	} else {
		wgpuDevicePoll(device, xx true, null);

		data := cast(*READ_PIXEL_RESULT)wgpuBufferGetMappedRange(renderer.readback_buffer, 0, READ_DATA_SIZE);
		result := data.*;

		wgpuBufferUnmap(renderer.readback_buffer);
		WAITING_FOR_BUFFER_MAPPED_STATE = false;
		return true, result;
	}
}

READ_PIXEL_RESULT :: [COMPONENTS_COUNT]DATA_TYPE;

#scope_file

READ_PIXEL_BUFFER_SIZE :: 256;
READ_DATA_SIZE :: 4;
COMPONENTS_COUNT :: 4;
DATA_TYPE :: u8;
WAITING_FOR_BUFFER_MAPPED_STATE := false;

wgpu_render_pixel_async_callback :: (status: WGPUBufferMapAsyncStatus, userdata: *void) #c_call {
	if(status!=WGPUBufferMapAsyncStatus.Success){
		new_context: #Context;
		push_context new_context {
			print("*** status:%\n", status);
		}
	}
}
