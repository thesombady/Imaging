module renderengine

import mathengine {Vertex}
import math

pub struct Color{
	Vertex
}

pub fn write_color(pixel_color &Vertex, samples_per_pixel int) string {
	x := int(256 * clamp(math.sqrt(pixel_color.x / samples_per_pixel), 0.0, 0.999))
	y := int(256 * clamp(math.sqrt(pixel_color.y / samples_per_pixel), 0.0, 0.999))
	z := int(256 * clamp(math.sqrt(pixel_color.z / samples_per_pixel), 0.0, 0.999))
	return "$x $y $z\n"
} 