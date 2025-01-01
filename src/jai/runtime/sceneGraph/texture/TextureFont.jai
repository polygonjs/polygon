
#if WASM {
	FONT_TEXTURE: Texture = .{
		size = TEXTURE_SIZE,
		data = TMP_DATA.data
	};
} else {
	FONT_TEXTURE: Texture = .{
		size = TEXTURE_SIZE,
		data = null//FONT_TEXTURE_DATA.data,
	};
};

loadFontImage :: () {
	#if WASM {
		loadFontImage_With_web_api();
	} else {
		loadFontImage_With_stb_image();
	}
}


#if WASM {
	TMP_DATA :[TEXTURE_DATA_SIZE]u8;
	loadFontImage_With_web_api :: () {
		// FONT_TEXTURE.data = TMP_DATA.data;
		loadFontData(FONT_TEXTURE_DATA.data, FONT_TEXTURE_DATA.count, TMP_DATA.data);
	}
} else {
	loadFontImage_With_stb_image :: () {
		components: s32;
		width: s32;
		height: s32;
		// print("FONT DATA: %, %, %, %, %\n", FONT_TEXTURE_DATA.count, FONT_TEXTURE_DATA.data[0], FONT_TEXTURE_DATA.data[1], FONT_TEXTURE_DATA.data[2], FONT_TEXTURE_DATA.data[3]);
		data := stbi_load_from_memory(FONT_TEXTURE_DATA.data, cast(s32) FONT_TEXTURE_DATA.count, *width, *height, *components, 4);
		if !data {
			log_error("Unable to decompress the image data!\n");
			return;
		}
		print("FONT IMAGE: %x% _%, %, %\n", width, height, components, width*height*components, FONT_TEXTURE.size[0]*FONT_TEXTURE.size[1]*4);

		assert(width==TEXTURE_WIDTH, "width != TEXTURE_WIDTH");
		assert(height==TEXTURE_HEIGHT, "height != TEXTURE_HEIGHT");
		// #if WASM {
		// 	debugImageDataPng(FONT_TEXTURE_DATA.data, FONT_TEXTURE_DATA.count);
		// }

		FONT_TEXTURE.data = data;

		// return data;
	}
}

fontTextureCharacterIndex :: (char: u8) -> u8{
	return INDEX_PER_CHARACTER[char];//table_find(*INDEX_PER_CHARACTER, char);
}


fontTextureCharacterUv :: (char: u8, uvMult: Vector2) -> Vector2 {
	index := fontTextureCharacterIndex(char);
	
	indexNormalized :float= cast(float)index / CHARACTERS_PER_ROW;
	row :float= xx floor(indexNormalized);
	posInRow :float= index - row*CHARACTERS_PER_ROW;
	
	uvStart :Vector2 = .{
		posInRow / CHARACTERS_PER_ROW,
		row / ROWS_COUNT,
	};
	uvOffset :Vector2 = .{
		uvMult.x / CHARACTERS_PER_ROW,
		uvMult.y / ROWS_COUNT,
	};
	// print("get % -> %, indexNormalized=%, row=%, posInRow=%, uvStart=%, uv=%\n", char, index, indexNormalized, row, posInRow, uvStart, uvStart + uvOffset);
	return uvStart + uvOffset;
}


#placeholder FONT_TEXTURE_DATA;

#scope_file

CHARACTERS_PER_ROW: float: 10;
ROWS_COUNT: u32: 10;
CHARACTERS :string: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_";
INDEX_PER_CHARACTER: [256]u8 = #run _initIndexPerCharacter();

TEXTURE_WIDTH: u32: 200;//256;
TEXTURE_HEIGHT: u32: 200;//128;
TEXTURE_DATA_SIZE: u32: TEXTURE_WIDTH*TEXTURE_HEIGHT*4;
TEXTURE_SIZE: TEXTURE_SIZE_TYPE: .[TEXTURE_WIDTH, TEXTURE_HEIGHT];



_initIndexPerCharacter :: ()->[256]u8 {
	data:[256]u8;
	// init(*INDEX_PER_CHARACTER, CHARACTERS.count);
	// characters :[CHARACTERS.count]char;
	for i: 0..CHARACTERS.count-1 {
		// characters[i] = CHARACTERS[i];
		char := CHARACTERS[i];
		data[char] = xx i;
		// table_set(*INDEX_PER_CHARACTER, char, i);
		// print("set % -> %\n", char, i);
	}
	// INDEX_PER_CHARACTER.set(characters, "0");
	return data;
}
