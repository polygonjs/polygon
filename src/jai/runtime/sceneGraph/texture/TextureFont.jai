
FONT_TEXTURE: Texture = .{
	size = TEXTURE_SIZE,
	data = null//FONT_TEXTURE_DATA.data,
};

loadFontImage :: ()->*u8 {
	components: s32;
	width: s32;
	height: s32;
	print("FONT DATA: %, %, %, %, %\n", FONT_TEXTURE_DATA.count, FONT_TEXTURE_DATA.data[0], FONT_TEXTURE_DATA.data[1], FONT_TEXTURE_DATA.data[2], FONT_TEXTURE_DATA.data[3]);
	data := stbi_load_from_memory(FONT_TEXTURE_DATA.data, cast(s32) FONT_TEXTURE_DATA.count, *width, *height, *components, 4);
	if !data {
		log_error("Unable to decompress the image data!\n");
		return null;
	}
	print("FONT IMAGE: %x% _%, %, %\n", width, height, components, width*height*components, FONT_TEXTURE.size[0]*FONT_TEXTURE.size[1]*4);

	#if WASM {
		debugImageDataPng(FONT_TEXTURE_DATA.data, FONT_TEXTURE_DATA.count);
	}

	return data;
}
// #placeholder FONT_TEXTURE_DATA;


#scope_file

TEXTURE_SIZE: TEXTURE_SIZE_TYPE: .[256, 128];
// FONT_TEXTURE_DATA_SIZE :s64: #run _getFontTextureDataSize();
// FONT_TEXTURE_DATA :: #run add_global_data(_createTextureData(), .READ_ONLY);


// _getFontTextureDataSize :: () -> s64 #compile_time {
// 	content := read_entire_file(FILE_PATH);

// 	print("content.count: %\n", content.count);

// 	return content.count;
// }


#import "Compiler";