module mathengine
// import math

pub struct Color{
pub: r u8 = 255
	g u8 = 255
	b u8 = 255
}

pub struct Mesh{
	mut: data []Triangle
		solid bool = true
pub	mut: color Color = Color{}
	vel Vertex = Vertex{x: 0, y: 0, z: 0} // a null velocity vector
}

pub fn (m &Mesh) new(triangles []Triangle) &Mesh {
	return &Mesh{data: triangles}
}

pub fn (m &Mesh) mul (scalar f64) &Mesh {
	mut new_data := []Triangle{len: m.data.len}
	for i := 0; i < m.data.len; i++ {
		new_data << m.data[i].mul(scalar)
	}
	return &Mesh{data: new_data}
}

pub fn (m &Mesh) add (other &Triangle) &Mesh{
	mut new_data := []Triangle{len: m.data.len + 1}
	for i := 0; i < m.data.len; i++ {
		new_data << m.data[i]
	}
	new_data << other
	return &Mesh{data: new_data}
}

pub fn (m &Mesh) center() &Vertex {
	mut x := 0.0
	mut y := 0.0
	mut z := 0.0
	for i:=0; i < m.data.len; i++ {
		x += (m.data[i].p1.x + m.data[i].p2.x + m.data[i].p3.x) / 3
		y += (m.data[i].p1.y + m.data[i].p2.y + m.data[i].p3.y) / 3
		z += (m.data[i].p1.z + m.data[i].p2.z + m.data[i].p3.z) / 3
	}
	return &Vertex{x: x / m.data.len, y: y / m.data.len, z: z / m.data.len}
}

pub fn (m &Mesh) length() f64 {
	mut len := 0.0
	center := m.center()
	for i:=0; i < m.data.len; i++ {
		center_tri := m.data[i].center()
		if center_tri > center && (center_tri-center).length() > len {
			len = (center_tri-center).length()
		}
	}
	return len
}

pub fn (m &Mesh) collission (ray &Vertex) bool{
	center := m.center()
	len := m.length()
	if (center.x + len) - ray.x < 0 && (center.y + len) - ray.y < 0 {
		return true
	}
	return false
}