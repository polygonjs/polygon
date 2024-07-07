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

#load "native/helpers.jai";
#load "native/uniforms_helpers.jai";
#load "native/multisample.jai";

WINDOW_WIDTH  :: 1280;
WINDOW_HEIGHT :: 720;
MSAA :: true;

wgpu_log_callback :: (level: wgpu.LogLevel, msg: *u8, userdata: *void) #c_call {
	print_c("[WGPU :: %]: %\n", level, to_string(msg));
}




#load "common/shaders.jai";
#load "common/scene_data.jai";



main :: () {
	SHADER :: #run create_shaders();
	SCENE_DATA : SceneData = create_scene_data();

	SDL_Init(SDL_INIT_VIDEO);

	window := SDL_CreateWindow("Jai WGPU", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, WINDOW_WIDTH, WINDOW_HEIGHT, SDL_WINDOW_ALLOW_HIGHDPI);
	assert(window != null, "Could not create window: %\n", to_string(SDL_GetError()));

	wgpu.SetLogCallback(wgpu_log_callback, null);
	wgpu.SetLogLevel(.Error);

	instance_desc: wgpu.InstanceDescriptor;
	instance := wgpu.CreateInstance(*instance_desc);
	assert(instance != null, "Instance is not created correctly");

	surface := create_surface(instance, window);
	assert(surface != null, "Surface is not created correctly");

	adapter := request_adapter(instance, surface, powerPreference = .HighPerformance);
	assert(adapter != null, "Adapter is not created correctly");

	device := request_device(adapter);
	assert(device != null, "Device is not created correctly");

	wgpu.DeviceSetUncapturedErrorCallback(device, (type: wgpu.ErrorType, msg: *u8, user_data: *void) #c_call {
		print_c("Uncaptured Error (%d): %s\n", type, to_string(msg));
	}, null);

	queue := wgpu.DeviceGetQueue(device);
	assert(queue != null, "Queue is not created correctly");

	shader := create_shader(device, SHADER);
	assert(shader != null, "Shader is not created correctly");

	pipeline_descriptor: wgpu.RenderPipelineDescriptor;
	update_pipeline_descriptor(*pipeline_descriptor, surface, adapter, device, shader, Vertex);
	update_pipeline_descriptor_multisample(*pipeline_descriptor, MSAA);
	pipeline := wgpu.DeviceCreateRenderPipeline(device, *pipeline_descriptor);
	assert(pipeline != null, "Pipeline is not created correctly");

	vertex_buffer, vertex_buffer_size := vertex_array_to_buffer(device, queue, SCENE_DATA.vertices);
	index_buffer, index_buffer_size := index_array_to_buffer(device, queue, SCENE_DATA.indices);
	uniform_buffer, uniform_buffer_size, bind_group := uniform_to_buffer(device, queue, pipeline, SCENE_DATA.object_uniforms);

	swap_chain_descriptor: wgpu.SwapChainDescriptor;
	swapchain := create_swapchain(*swap_chain_descriptor, surface, adapter, device, WINDOW_WIDTH, WINDOW_HEIGHT);
	multisample_texture := create_multi_sample_texture_if_needed(device, *swap_chain_descriptor);

	wgpu.QueueSubmit(queue, 0, null);

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
		}
		time := SDL_GetTicks() / 1000.0;

		current_view := wgpu.SwapChainGetCurrentTextureView(swapchain);

		update_scene_data(*SCENE_DATA, time);
		update_vertex_array_to_buffer(vertex_buffer, queue, *SCENE_DATA);
		update_object_uniforms_to_buffer(uniform_buffer, queue, *SCENE_DATA);

		cmd_encoder := wgpu.DeviceCreateCommandEncoder(
			device,
			*(wgpu.CommandEncoderDescriptor.{label = "Main Command Encoder"}),
		);

		colorAttachment := wgpu.RenderPassColorAttachment.{
			loadOp = wgpu.LoadOp.Clear,
			storeOp = wgpu.StoreOp.Store,
			clearValue = wgpu.Color.{0.0, 0.0, 0.0, 1.0},
		};

		colorAttachment.view = current_view;
		update_render_pass_description(*colorAttachment,*swap_chain_descriptor, *current_view, *multisample_texture, MSAA);

		render_pass_descriptor := wgpu.RenderPassDescriptor.{ label = "Main Render Pass" };
		render_pass_descriptor.colorAttachmentCount = 1;
		render_pass_descriptor.colorAttachments = *colorAttachment;

		render_pass := wgpu.CommandEncoderBeginRenderPass(cmd_encoder, *render_pass_descriptor);

		wgpu.RenderPassEncoderSetPipeline(render_pass, pipeline);
		dynamicOffsets:[0]u32;
		wgpu.RenderPassEncoderSetBindGroup(render_pass, 0, bind_group, 0, dynamicOffsets.data);
		wgpu.RenderPassEncoderSetVertexBuffer(render_pass, 0, vertex_buffer, 0, vertex_buffer_size);
		wgpu.RenderPassEncoderSetIndexBuffer(render_pass, index_buffer, wgpu.IndexFormat.Uint32, 0, index_buffer_size);

		wgpu.RenderPassEncoderDrawIndexed(render_pass, cast(u32) SCENE_DATA.indices.count, 1, 0, 0, 0);
		wgpu.RenderPassEncoderEnd(render_pass);
		wgpu.TextureViewRelease(current_view);

		cmd_buffer := wgpu.CommandEncoderFinish(cmd_encoder, *(wgpu.CommandBufferDescriptor.{label = "Main Command Buffer"}));

		wgpu.QueueSubmit(queue, 1, *cmd_buffer);
		wgpu.SwapChainPresent(swapchain);
	}

	// Close and destroy the window
	SDL_DestroyWindow(window);

	// Clean up
	SDL_Quit();
}

