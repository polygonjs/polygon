const SCALE_FACTOR: f32 = 1000.0;
fn floatToFixedPoint(value: f32) -> i32 { return i32(value * SCALE_FACTOR); }
fn fixedPointToFloat(value: i32) -> f32 { return f32(value) / SCALE_FACTOR; }