module renderengine

import mathengine {Vertex}

pub struct Ray{
pub mut: origin Vertex
	direction Vertex
}

pub fn (r &Ray )at(t f64) Vertex{
	return r.origin + r.direction.mul(t)
}