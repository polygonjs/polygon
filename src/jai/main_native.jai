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
wgpu :: #import "wgpu";

#load "native/helpers.jai";

WINDOW_WIDTH  :: 1280;
WINDOW_HEIGHT :: 720;

wgpu_log_callback :: (level: wgpu.LogLevel, msg: *u8, userdata: *void) #c_call {
	print_c("[WGPU :: %]: %\n", level, to_string(msg));
}

Vertex :: struct {
	position: Vector3;
	color: Vector3;
}

SHADER :: #string WGSL
	struct VertexInput {
		@location(0) position: vec3<f32>,
		@location(1) color: vec3<f32>,
	};

	struct VertexOutput {
		@builtin(position) clip_position: vec4<f32>,
		@location(0) color: vec3<f32>,
	};

	@vertex
	fn vertex(model: VertexInput) -> VertexOutput {
		var out: VertexOutput;
		out.clip_position = vec4<f32>(model.position, 1.0);
		out.color = model.color;
		return out;
	}

	@fragment
	fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
		return vec4<f32>(in.color, 1.0);
	}
WGSL;

VERTICES := Vertex.[
	.{ position=.{0.0, 0.5, 0.0}, color=.{1.0, 0.0, 0.0} },
	.{ position=.{-0.5, -0.5, 0.0}, color=.{0.0, 1.0, 0.0} },
	.{ position=.{0.5, -0.5, 0.0}, color=.{0.0, 0.0, 1.0} },
];

update_vertex_array_to_buffer :: (buffer:wgpu.Buffer, queue: wgpu.Queue, vertices: []Vertex) {
	size := cast(u64) vertices.count * size_of(Vertex);
	wgpu.QueueWriteBuffer(queue, buffer, 0, vertices.data, size);
}

main :: () {
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

	vertex_buffer, vertex_buffer_size := vertex_array_to_buffer(device, queue, VERTICES);

	pipeline := create_pipeline(surface, adapter, device, shader, Vertex);
	assert(pipeline != null, "Pipeline is not created correctly");

	swapchain := create_swapchain(surface, adapter, device, WINDOW_WIDTH, WINDOW_HEIGHT);

	wgpu.QueueSubmit(queue, 0, null);

	exit := false;
	while !exit {
		event: SDL_Event;
		while SDL_PollEvent(*event) {
			if event.type == SDL_QUIT {
				exit = true;
			}
		}
		time := SDL_GetTicks() / 1000.0;

		current_view := wgpu.SwapChainGetCurrentTextureView(swapchain);

		VERTICES[0].position.y = sin(4*time) / 2.0;
		update_vertex_array_to_buffer(vertex_buffer, queue, VERTICES);

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

		render_pass_descriptor := wgpu.RenderPassDescriptor.{ label = "Main Render Pass" };
		render_pass_descriptor.colorAttachmentCount = 1;
		render_pass_descriptor.colorAttachments = *colorAttachment;

		render_pass := wgpu.CommandEncoderBeginRenderPass(cmd_encoder, *render_pass_descriptor);

		wgpu.RenderPassEncoderSetPipeline(render_pass, pipeline);
		wgpu.RenderPassEncoderSetVertexBuffer(render_pass, 0, vertex_buffer, 0, vertex_buffer_size);

		wgpu.RenderPassEncoderDraw(render_pass, VERTICES.count, 1, 0, 0);
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

