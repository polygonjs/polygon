sdl_event_print :: (event: *SDL_Event){
	{
		info := type_info(type_of(<<event));
		log("event contains the following members:");
		for info.members {
			log("%: % of type %", it_index, it.name, type_to_string(it.type));
		}
	}
	{
		info := type_info(type_of((<<event).window));
		log("event.window contains the following members:");
		for info.members {
			log("%: % of type %", it_index, it.name, type_to_string(it.type));
		}
	}
}