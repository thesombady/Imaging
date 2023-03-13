module mathengine

pub struct Triangle{
	p1 Vertex
	p2 Vertex
	p3 Vertex
}

pub fn (t &Triangle) center() Vertex {
	return Vertex{
		x: (t.p1.x + t.p2.x + t.p3.x) / 3,
		y: (t.p1.y + t.p2.y + t.p3.y) / 3,
		z: (t.p1.z + t.p2.z + t.p3.z) / 3,
	}
}

pub fn (t &Triangle) shift (o &Vertex) Triangle {
	return Triangle{
		p1: t.p1 + o,
		p2: t.p2 + o,
		p3: t.p3 + o,
	}
}

pub fn (t &Triangle) mul (s f64) Triangle {
	center := t.center()
	// println(center)
	return Triangle{
		p1: (t.p1 - center).mul(s) + center,
		p2: (t.p2 - center).mul(s) + center,
		p3: (t.p3 - center).mul(s) + center,
	}
}

pub fn (t &Triangle) == (o &Triangle) bool {
	return t.p1 == o.p1 && t.p2 == o.p2 && t.p3 == o.p3
}

pub fn (t &Triangle) normal() (Vertex, Vertex){
	vec1 := t.p2 - t.p1
	vec2 := t.p3 - t.p1
	return vec1.cross(vec2).normalize(), t.center()
}
 pub fn (t &Triangle) get_vertices() (&Vertex, &Vertex, &Vertex) {
	return &t.p1, &t.p2, &t.p3
 }
