
print_type_info :: (builder: *String_Builder, $T: Type, $prefix:string){
 
    info := type_info(T);
    member_names: [..]string;
    for info.members {
        array_add(*member_names, it.name);
    }
    generic_member_names := join(..member_names, separator = "\" | \"");


    append(builder, tprint("export const %:StructInfo<\"%\"> = {\n", T, generic_member_names));
    append(builder, tprint("size: %n,\n", size_of(T)));
    append(builder, "members: {\n");
	for info.members {
        member_name := it.name;
        member_offset := it.offset_in_bytes;
        member_type := type_to_string(it.type);
        member_type_size := ifx contains(member_type, prefix) then
            ifx it.type.type == Type_Info_Tag.ENUM then "ENUM_SIZE" else  tprint("%.size", member_type)
        else
            tprint("WASM_DATA_SIZE.%", member_type);
        size := ifx contains(member_type, "*") then "WASM_DATA_SIZE.u64" else member_type_size;

        array_view := "getU8";
        if type_to_string(it.type) == {
            case "u8"; {array_view = "getU8";}
            case "u16"; {array_view = "getU16";}
            case "u32"; {array_view = "getU32";}
            case "u64"; {array_view = "getU64";}
            case "s32"; {array_view = "getS32";}
            case "float32"; {array_view = "getFLOAT32";}
            case "float64"; {array_view = "getFLOAT64";}
        }
        if contains(type_to_string(it.type), "*") {
            array_view = "getU64";
        }
        ifx it.type.type == Type_Info_Tag.ENUM {
            array_view = "getU32";
        }

        append(builder, tprint("%: {size: %, offset: %n, arrayView: %},", member_name, size, member_offset, array_view));
	}
    append(builder, "}};\n\n");
}

#load "../../runtime/core/utils/Type.jai";
#import "Basic";
#import "File";
#import "String";
#import "Compiler";