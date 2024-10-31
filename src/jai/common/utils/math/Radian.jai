// https://discord.com/channels/661732390355337246/784843664651190273/1143770377957425184
// Degrees :: #type,isa float;
// Radians :: #type,isa float;

// PI :: 3.1415927;

// radians :: inline (degrees : Degrees) -> Radians {
//     return cast(Radians) (degrees * PI / 180.0);
// }

deg_to_rad :: inline (degrees : float) -> float {
    return cast(float) (degrees * PI / 180.0);
}