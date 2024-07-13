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
#load "native/helpers_sdl.jai";
#load "native/helpers_webgpu.jai";
#load "native/uniforms_helpers.jai";
#load "native/depth.jai";
#load "native/multisample.jai";
#load "native/shaders.jai";
#load "native/orbit_controls.jai";

WINDOW_WIDTH  :u32: 1280;
WINDOW_HEIGHT :u32: 720;
INIT_RATIO :float = (cast(float) WINDOW_WIDTH) / (cast(float) WINDOW_HEIGHT);



wgpu_log_callback :: (level: wgpu.LogLevel, msg: *u8, userdata: *void) #c_call {
	print_c("[WGPU :: %]: %\n", level, to_string(msg));
}


main :: () {
	SHADER :: #run create_shaders();
	SCENE_DATA :SceneData= create_scene_data(INIT_RATIO);
	orbit_controls :OrbitControls;

	SDL_Init(SDL_INIT_VIDEO);

	window := SDL_CreateWindow("Polygon 2",
		SDL_WINDOWPOS_UNDEFINED,
		SDL_WINDOWPOS_UNDEFINED,
		xx WINDOW_WIDTH,
		xx WINDOW_HEIGHT,
		SDL_WINDOW_ALLOW_HIGHDPI|SDL_WINDOW_RESIZABLE
	);
	assert(window != null, "Could not create window: %\n", to_string(SDL_GetError()));

	wgpu.SetLogCallback(wgpu_log_callback, null);
	wgpu.SetLogLevel(.Error);

	wgpu_context: WGPUContext = wgpu_context_create(window, WINDOW_WIDTH, WINDOW_HEIGHT);
	

	queue := wgpu.DeviceGetQueue(wgpu_context.device);
	assert(queue != null, "Queue is not created correctly");

	shader := create_shader(wgpu_context.device, SHADER);
	assert(shader != null, "Shader is not created correctly");

	pipeline_descriptor: wgpu.RenderPipelineDescriptor;
	fragment_state: wgpu.FragmentState;
	color_target_state: wgpu.ColorTargetState;
	wasm_vertex_layout_layout := wasm_make_vertex_layout(Vertex);
	vertex_buffer_layout := Wasm_VertexBufferLayout_to_wgpu(wasm_vertex_layout_layout);
	wgpu_context.preferred_texture_format = wgpu.SurfaceGetPreferredFormat(wgpu_context.surface, wgpu_context.adapter);
	fragment_state_prepare(*fragment_state, *color_target_state, shader, wgpu_context.preferred_texture_format);
	update_pipeline_descriptor( *pipeline_descriptor, wgpu_context.device, shader, *vertex_buffer_layout, *fragment_state );
	update_pipeline_descriptor_multisample(*wgpu_context, *pipeline_descriptor);
	depth_stencil_state: wgpu.DepthStencilState;
	update_pipeline_descriptor_depth(*wgpu_context, *pipeline_descriptor, *depth_stencil_state);
	// pipeline_descriptor_print(*pipeline_descriptor);
	pipeline := wgpu.DeviceCreateRenderPipeline(wgpu_context.device, *pipeline_descriptor);
	assert(pipeline != null, "Pipeline is not created correctly");

	vertex_buffer, vertex_buffer_size := vertex_array_to_buffer(wgpu_context.device, queue, SCENE_DATA.vertices);
	index_buffer, index_buffer_size := index_array_to_buffer(wgpu_context.device, queue, SCENE_DATA.indices);
	object_uniform_buffer, object_uniform_buffer_size, object_bind_group := object_uniform_to_buffer(wgpu_context.device, queue, pipeline, SCENE_DATA.object_uniforms);
	camera_uniform_buffer, camera_uniform_buffer_size, camera_bind_group := camera_uniform_to_buffer(wgpu_context.device, queue, pipeline, SCENE_DATA.camera_uniforms);


	wgpu.QueueSubmit(queue, 0, null);

	do_exit := false;
	while !do_exit {
		event: SDL_Event;
		while SDL_PollEvent(*event) {
			// print("Event: %\n", event.type);
			if event.type == {
				case SDL_QUIT; {do_exit = true;}
				case SDL_WINDOWEVENT; {
					if (event.window.event == SDL_WINDOWEVENT_RESIZED) {
						new_width := event.window.data1;
						new_height := event.window.data2;
						if(new_width > 0 && new_height > 0){
							webgpu_handle_resize(*wgpu_context, xx event.window.data1, xx event.window.data2);
							SCENE_DATA.camera_aspect = (cast(float32) event.window.data1) / (cast(float32) event.window.data2);
							update_camera_data_projection(*SCENE_DATA);
						}
					}
				}
				case SDL_KEYDOWN; {
					if event.key.keysym.sym == SDLK_ESCAPE {
						do_exit = true;
					}
				}
			}
			orbit_controls_process_event(*orbit_controls, *event);
		}
		time := SDL_GetTicks() / 1000.0;
		frame := surface_create_current_view( *wgpu_context );
		create_multi_sample_texture_if_needed( *wgpu_context );
		create_depth_texture_if_needed( *wgpu_context );
		//
		orbit_controls_update_camera(*orbit_controls, *SCENE_DATA.camera_data[0]);
		update_scene_data(*SCENE_DATA, time);
		update_scene_data_uniforms(*SCENE_DATA);
		update_vertex_array_to_buffer(vertex_buffer, queue, *SCENE_DATA);
		update_object_uniforms_to_buffer(object_uniform_buffer, queue, *SCENE_DATA);
		update_camera_uniforms_to_buffer(camera_uniform_buffer, queue, *SCENE_DATA);

		cmd_encoder := wgpu.DeviceCreateCommandEncoder(
			wgpu_context.device,
			*(wgpu.CommandEncoderDescriptor.{label = "Main Command Encoder"}),
		);

		colorAttachment := wgpu.RenderPassColorAttachment.{
			loadOp = wgpu.LoadOp.Clear,
			storeOp = wgpu.StoreOp.Store,
			clearValue = wgpu_context.bg_color,
		};

		update_render_pass_descriptor_multisample(*wgpu_context, *colorAttachment, *frame);

		render_pass_descriptor := wgpu.RenderPassDescriptor.{ label = "Main Render Pass" };
		render_pass_descriptor.colorAttachmentCount = 1;
		render_pass_descriptor.colorAttachments = *colorAttachment;
		update_render_pass_descriptor_depth(*wgpu_context, *render_pass_descriptor);
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

		cmd_buffer := wgpu.CommandEncoderFinish(cmd_encoder, *(wgpu.CommandBufferDescriptor.{label = "Main Command Buffer"}));

		wgpu.QueueSubmit(queue, 1, *cmd_buffer);

		wgpu.SurfacePresent(wgpu_context.surface);
		
		wgpu.CommandBufferRelease(cmd_buffer);
		wgpu.RenderPassEncoderRelease(render_pass_encoder);
		wgpu.CommandEncoderRelease(cmd_encoder);
		wgpu.TextureViewRelease(frame);
		wgpu.TextureRelease(wgpu_context.surface_texture.texture);
		multisample_release(*wgpu_context);
		depth_release(*wgpu_context);
		
	}

	// Close and destroy the window
	// see https://github.com/gfx-rs/wgpu-native/blob/trunk/examples/triangle/main.c
	wgpu.RenderPipelineRelease(pipeline);
	// wgpu.PipelineLayoutRelease(pipeline_layout);
	// wgpu.ShaderModuleRelease(shader_module);
	// wgpu.SurfaceCapabilitiesFreeMembers(surface_capabilities);
	// wgpu.QueueRelease(queue);
	wgpu.DeviceRelease(wgpu_context.device);
	wgpu.AdapterRelease(wgpu_context.adapter);
	wgpu.SurfaceRelease(wgpu_context.surface);
	SDL_DestroyWindow(window);
	wgpu.InstanceRelease(wgpu_context.instance);

	// Clean up
	SDL_Quit();
}

