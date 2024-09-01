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



events_data_update :: (events_data :*EventsData, sdl_event :*SDL_Event){
	if sdl_event.type == {
		case SDL_MOUSEBUTTONDOWN; {
			if (sdl_event.button.button == SDL_BUTTON_LEFT) {
				events_data.mouseButton.left = true;
			}
			if (sdl_event.button.button == SDL_BUTTON_MIDDLE) {
				events_data.mouseButton.middle = true;
			}
			if (sdl_event.button.button == SDL_BUTTON_RIGHT) {
				events_data.mouseButton.right = true;
			}
		}
		case SDL_MOUSEBUTTONUP; {
			if (sdl_event.button.button == SDL_BUTTON_LEFT) {
				events_data.mouseButton.left = false;
			}
			if (sdl_event.button.button == SDL_BUTTON_MIDDLE) {
				events_data.mouseButton.middle = false;
			}
			if (sdl_event.button.button == SDL_BUTTON_RIGHT) {
				events_data.mouseButton.right = false;
			}
		}
		case SDL_MOUSEMOTION; {
			events_data.cursor.x = xx max(0, sdl_event.motion.x);
			events_data.cursor.y = xx max(0, sdl_event.motion.y);
		}
		case SDL_MOUSEWHEEL; {
			events_data.wheel = xx sdl_event.wheel.y;
		}
		case SDL_TEXTINPUT; {
			memcpy(events_data.text.data, sdl_event.text.text.data, TEXTINPUTEVENT_TEXT_SIZE);
		}
	}
}