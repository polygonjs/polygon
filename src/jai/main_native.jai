#if OS == .LINUX  {
	// in order to import gcc_s, I initially tried:
	// gcc_s  :: #library,system,link_always "libgcc_s.so.1";
	// as the symlink from libgcc_s.so did not exist. This worked fine,
	// but to be cleaner, I created it with:
	// sudo ln -s /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so
	// and now we can import with "gcc_s"
	gcc_s  :: #library,system,link_always "gcc_s";
	// c  :: #library,system,link_always "libc";
	// m  :: #library,system,link_always "libm";
	// dl :: #library,system,link_always "libdl";
	// pt :: #library,system,link_always "libpthread";
}

#import "Basic";
#import "SDL";
#import "Math";
#load "common/wgpu_mock.jai";
wgpu :: #import "wgpu";

#load "common/math_helper.jai";
#load "common/orbit_controls.jai";
#load "common/scene_data.jai";
#load "native/helpers.jai";
#load "native/uniforms_helpers.jai";
#load "native/depth.jai";
#load "native/multisample.jai";
#load "native/shaders.jai";
#load "native/orbit_controls.jai";

WINDOW_WIDTH  :: 720;
WINDOW_HEIGHT :: 720;
MSAA :: true;
DEPTH :: true; // depth may not be needed if we only have 1 raymarched shader
BACKGROUND_COLOR :: wgpu.Color.{0.0, 0.0, 0.2, 1.0};

WGPUConfig :: struct {
	instance: wgpu.Instance;
	surface: wgpu.Surface;
	adapter:wgpu.Adapter;
	device: wgpu.Device ;
	config: wgpu.SurfaceConfiguration;
};


wgpu_log_callback :: (level: wgpu.LogLevel, msg: *u8, userdata: *void) #c_call {
	print_c("[WGPU :: %]: %\n", level, to_string(msg));
}


main :: () {
	SHADER :: #run create_shaders();
	SCENE_DATA :SceneData= create_scene_data(WINDOW_WIDTH / WINDOW_HEIGHT);
	orbit_controls :OrbitControls;

	SDL_Init(SDL_INIT_VIDEO);

	window := SDL_CreateWindow("Polygon 2", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, WINDOW_WIDTH, WINDOW_HEIGHT, SDL_WINDOW_ALLOW_HIGHDPI);
	assert(window != null, "Could not create window: %\n", to_string(SDL_GetError()));

	wgpu.SetLogCallback(wgpu_log_callback, null);
	wgpu.SetLogLevel(.Error);

	config: WGPUConfig;
	instance_desc: wgpu.InstanceDescriptor;
	config.instance = wgpu.CreateInstance(*instance_desc);
	assert(config.instance != null, "Instance is not created correctly");

	config.surface = create_surface(config.instance, window);
	assert(config.surface != null, "Surface is not created correctly");

	config.adapter = request_adapter(config.instance, config.surface, powerPreference = .HighPerformance);
	assert(config.adapter != null, "Adapter is not created correctly");

	config.device = request_device(config.adapter, WINDOW_WIDTH, WINDOW_HEIGHT);
	assert(config.device != null, "Device is not created correctly");

	surface_capabilities :wgpu.SurfaceCapabilities;
	wgpu.SurfaceGetCapabilities(config.surface, config.adapter, *surface_capabilities);
	config.config = wgpu.SurfaceConfiguration.{
		device = config.device,
		usage = xx wgpu.TextureUsage.RenderAttachment,
		format = surface_capabilities.formats[0],
		presentMode = wgpu.PresentMode.Fifo,
		alphaMode = surface_capabilities.alphaModes[0],
		width = WINDOW_WIDTH,
		height = WINDOW_HEIGHT,
	};
	wgpu.SurfaceConfigure(config.surface, *config.config);

	wgpu.DeviceSetUncapturedErrorCallback(config.device, (type: wgpu.ErrorType, msg: *u8, user_data: *void) #c_call {
		print_c("Uncaptured Error (%d), %s\n", type, to_string(msg));
	}, null);

	queue := wgpu.DeviceGetQueue(config.device);
	assert(queue != null, "Queue is not created correctly");

	shader := create_shader(config.device, SHADER);
	assert(shader != null, "Shader is not created correctly");

	pipeline_descriptor: wgpu.RenderPipelineDescriptor;
	fragment_state: wgpu.FragmentState;
	color_target_state: wgpu.ColorTargetState;
	wasm_vertex_layout_layout := wasm_make_vertex_layout(Vertex);
	vertex_buffer_layout := Wasm_VertexBufferLayout_to_wgpu(wasm_vertex_layout_layout);
	preferred_texture_format :wgpu.TextureFormat = wgpu.SurfaceGetPreferredFormat(config.surface, config.adapter);
	fragment_state_prepare(*fragment_state, *color_target_state, shader, preferred_texture_format);
	update_pipeline_descriptor( *pipeline_descriptor, config.device, shader, *vertex_buffer_layout, *fragment_state );
	update_pipeline_descriptor_multisample(*pipeline_descriptor, MSAA);
	depth_stencil_state: wgpu.DepthStencilState;
	update_pipeline_descriptor_depth(*pipeline_descriptor, *depth_stencil_state, DEPTH);
	// pipeline_descriptor_print(*pipeline_descriptor);
	pipeline := wgpu.DeviceCreateRenderPipeline(config.device, *pipeline_descriptor);
	assert(pipeline != null, "Pipeline is not created correctly");

	vertex_buffer, vertex_buffer_size := vertex_array_to_buffer(config.device, queue, SCENE_DATA.vertices);
	index_buffer, index_buffer_size := index_array_to_buffer(config.device, queue, SCENE_DATA.indices);
	object_uniform_buffer, object_uniform_buffer_size, object_bind_group := object_uniform_to_buffer(config.device, queue, pipeline, SCENE_DATA.object_uniforms);
	camera_uniform_buffer, camera_uniform_buffer_size, camera_bind_group := camera_uniform_to_buffer(config.device, queue, pipeline, SCENE_DATA.camera_uniforms);

	//swap_chain_descriptor: wgpu.SwapChainDescriptor;
	//swapchain := create_swapchain(*swap_chain_descriptor, surface, adapter, device, WINDOW_WIDTH, WINDOW_HEIGHT);
	tmp_surface_texture :wgpu.SurfaceTexture;
	wgpu.SurfaceGetCurrentTexture(config.surface, *tmp_surface_texture);
	multisample_texture_descriptor : wgpu.TextureDescriptor;
	multisample_texture := create_multi_sample_texture_if_needed(config.device, *tmp_surface_texture, preferred_texture_format, *multisample_texture_descriptor, MSAA);
	viewFormats := DEPTH_TEXTURE_FORMAT;
	depth_texture := create_depth_texture_if_needed(config.device, *tmp_surface_texture, *viewFormats, DEPTH, MSAA);
	wgpu.TextureRelease(tmp_surface_texture.texture);

	// colorAttachment := wgpu.RenderPassColorAttachment.{
	// 	loadOp = wgpu.LoadOp.Clear,
	// 	storeOp = wgpu.StoreOp.Store,
	// 	clearValue = wgpu.Color.{0.0, 0.0, 0.0, 1.0},
	// };

	// render_pass_descriptor := wgpu.RenderPassDescriptor.{ label = "Main Render Pass" };
	// render_pass_descriptor.colorAttachmentCount = 1;
	// render_pass_descriptor.colorAttachments = *colorAttachment;
	// #if DEPTH {
	// 	init_render_pass_descriptor_depth(*render_pass_descriptor);
	// }


	wgpu.QueueSubmit(queue, 0, null);
	print("Z\n");

	do_exit := false;
	while !do_exit {
		event: SDL_Event;
		while SDL_PollEvent(*event) {
			// print("Event: %\n", event.type);
			if event.type == {
				case SDL_QUIT; {do_exit = true;}
				case SDL_KEYDOWN; {
					if event.key.keysym.sym == SDLK_ESCAPE {
						do_exit = true;
					}
				}
			}
			orbit_controls_process_event(*orbit_controls, *event);
		}
		time := SDL_GetTicks() / 1000.0;


		surface_texture :wgpu.SurfaceTexture;
		wgpu.SurfaceGetCurrentTexture(config.surface, *surface_texture);
		current_view_descriptor := wgpu.TextureViewDescriptor.{
			format = preferred_texture_format,
			dimension = wgpu.TextureViewDimension._2D,
			aspect = wgpu.TextureAspect.All,
			baseMipLevel = 0,
			mipLevelCount = 1,
			baseArrayLayer = 0,
			arrayLayerCount = 1,
		};
		frame := wgpu.TextureCreateView(surface_texture.texture, *current_view_descriptor);

		orbit_controls_update_camera(*orbit_controls, *SCENE_DATA.camera_data[0]);
		update_scene_data(*SCENE_DATA, time);
		update_scene_data_uniforms(*SCENE_DATA);
		update_vertex_array_to_buffer(vertex_buffer, queue, *SCENE_DATA);
		update_object_uniforms_to_buffer(object_uniform_buffer, queue, *SCENE_DATA);
		update_camera_uniforms_to_buffer(camera_uniform_buffer, queue, *SCENE_DATA);

		cmd_encoder := wgpu.DeviceCreateCommandEncoder(
			config.device,
			*(wgpu.CommandEncoderDescriptor.{label = "Main Command Encoder"}),
		);

		colorAttachment := wgpu.RenderPassColorAttachment.{
			loadOp = wgpu.LoadOp.Clear,
			storeOp = wgpu.StoreOp.Store,
			clearValue = BACKGROUND_COLOR,
		};

		//colorAttachment.view = current_view;
		texture_view_multisample := update_render_pass_descriptor_multisample(*colorAttachment, *frame, preferred_texture_format, *multisample_texture, MSAA);

		render_pass_descriptor := wgpu.RenderPassDescriptor.{ label = "Main Render Pass" };
		render_pass_descriptor.colorAttachmentCount = 1;
		render_pass_descriptor.colorAttachments = *colorAttachment;
		depth_texture_view := update_render_pass_descriptor_depth(*render_pass_descriptor, *depth_texture, DEPTH);
		render_pass_encoder := wgpu.CommandEncoderBeginRenderPass(cmd_encoder, *render_pass_descriptor);

		//
		wgpu.RenderPassEncoderSetPipeline(render_pass_encoder, pipeline);
		object_dynamicOffsets:[0]u32;
		wgpu.RenderPassEncoderSetBindGroup(render_pass_encoder, 0, object_bind_group, 0, object_dynamicOffsets.data);
		//
		camera_dynamicOffsets:[0]u32;
		// camera_dynamicOffsets[0] = 16*4;
		wgpu.RenderPassEncoderSetBindGroup(render_pass_encoder, 1, camera_bind_group, 0, camera_dynamicOffsets.data);
		//
		wgpu.RenderPassEncoderSetVertexBuffer(render_pass_encoder, 0, vertex_buffer, 0, vertex_buffer_size);
		wgpu.RenderPassEncoderSetIndexBuffer(render_pass_encoder, index_buffer, wgpu.IndexFormat.Uint32, 0, index_buffer_size);

		wgpu.RenderPassEncoderDrawIndexed(render_pass_encoder, xx SCENE_DATA.indices.count, 1, 0, 0, 0);
		wgpu.RenderPassEncoderEnd(render_pass_encoder);
		// wgpu.TextureViewRelease(frame);

		cmd_buffer := wgpu.CommandEncoderFinish(cmd_encoder, *(wgpu.CommandBufferDescriptor.{label = "Main Command Buffer"}));

		wgpu.QueueSubmit(queue, 1, *cmd_buffer);
		//wgpu.SwapChainPresent(swapchain);

		wgpu.SurfacePresent(config.surface);
		
		wgpu.CommandBufferRelease(cmd_buffer);
		wgpu.RenderPassEncoderRelease(render_pass_encoder);
		wgpu.CommandEncoderRelease(cmd_encoder);
		wgpu.TextureViewRelease(frame);
		wgpu.TextureRelease(surface_texture.texture);
		// if( texture_view_multisample ) wgpu.TextureViewRelease(texture_view_multisample); // this crashes when MSAA is disabled
		if( depth_texture_view ) wgpu.TextureViewRelease(depth_texture_view);
	
	}

	// Close and destroy the window
	// see https://github.com/gfx-rs/wgpu-native/blob/trunk/examples/triangle/main.c
	wgpu.RenderPipelineRelease(pipeline);
	// wgpu.PipelineLayoutRelease(pipeline_layout);
	// wgpu.ShaderModuleRelease(shader_module);
	// wgpu.SurfaceCapabilitiesFreeMembers(surface_capabilities);
	// wgpu.QueueRelease(queue);
	wgpu.DeviceRelease(config.device);
	wgpu.AdapterRelease(config.adapter);
	wgpu.SurfaceRelease(config.surface);
	SDL_DestroyWindow(window);
	wgpu.InstanceRelease(config.instance);

	// Clean up
	SDL_Quit();
}

