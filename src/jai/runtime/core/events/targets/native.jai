// sdl_event_print :: (event: *SDL_Event){
// 	{
// 		info := type_info(type_of(<<event));
// 		log("event contains the following members:");
// 		for info.members {
// 			log("%: % of type %", it_index, it.name, type_to_string(it.type));
// 		}
// 	}
// 	{
// 		info := type_info(type_of((<<event).window));
// 		log("event.window contains the following members:");
// 		for info.members {
// 			log("%: % of type %", it_index, it.name, type_to_string(it.type));
// 		}
// 	}
// }



eventsDataUpdate :: (using eventsData :*EventsData, sdl_event :*SDL_Event){
	if sdl_event.type == {
		case SDL_MOUSEBUTTONDOWN; {
			if (sdl_event.button.button == SDL_BUTTON_LEFT) {
				mouseButtonJustPressed.left = mouseButton.left == false;
				mouseButton.left = true;
			}
			if (sdl_event.button.button == SDL_BUTTON_MIDDLE) {
				mouseButtonJustPressed.middle = mouseButton.middle == false;
				mouseButton.middle = true;
			}
			if (sdl_event.button.button == SDL_BUTTON_RIGHT) {
				mouseButtonJustPressed.right = mouseButton.right == false;
				mouseButton.right = true;
			}
		}
		case SDL_MOUSEBUTTONUP; {
			if (sdl_event.button.button == SDL_BUTTON_LEFT) {
				mouseButtonJustReleased.left = mouseButton.left == true;
				mouseButton.left = false;
			}
			if (sdl_event.button.button == SDL_BUTTON_MIDDLE) {
				mouseButtonJustReleased.middle = mouseButton.middle == true;
				mouseButton.middle = false;
			}
			if (sdl_event.button.button == SDL_BUTTON_RIGHT) {
				mouseButtonJustReleased.right = mouseButton.right == true;
				mouseButton.right = false;
			}
		}
		case SDL_MOUSEMOTION; {
			prevCursor.x = cursor.x;
			prevCursor.y = cursor.y;
			cursor.x = xx max(0, sdl_event.motion.x);
			cursor.y = xx max(0, sdl_event.motion.y);
		}
		case SDL_MOUSEWHEEL; {
			wheel = xx sdl_event.wheel.y;
		}
		case SDL_TEXTINPUT; {
			memcpy(text.data, sdl_event.text.text.data, TEXTINPUTEVENT_TEXT_SIZE);
		}
	}
	eventsData.dirty = true;
}