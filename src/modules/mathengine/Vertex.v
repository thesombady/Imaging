module mathengine
import math
import rand

pub struct Vertex{
pub:x f64
	y f64
	z f64
}
pub fn (v &Vertex) + (o &Vertex) Vertex {
	return Vertex{v.x + o.x, v.y + o.y, v.z + o.z}
}

pub fn (v &Vertex) - (o &Vertex) Vertex {
	return Vertex{v.x - o.x, v.y - o.y, v.z - o.z}
}

pub fn (v &Vertex) * (o &Vertex) Vertex {
	return Vertex{v.x * o.x, v.y * o.y, v.z * o.z}
}

pub fn (v &Vertex) sum() f64 {
	return v.x + v.y + v.z
}

pub fn (v &Vertex) length() f64 {
	return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
}

pub fn (v &Vertex) length_squared() f64 {
	return v.x * v.x + v.y * v.y + v.z * v.z
}

pub fn (v &Vertex) div (scalar f64) Vertex {
	if scalar != 0 {
		return Vertex{
			x: v.x / scalar,
			y: v.y / scalar,
			z: v.z / scalar
		}
	} else {
		println('Error: Division by zero')
		return Vertex{0, 0, 0}
	}
}

pub fn (v &Vertex) dot (o &Vertex) f64 {
	return v.x * o.x + v.y * o.y + v.z * o.z
}

pub fn (v &Vertex) mul (scalar f64) Vertex {
	return Vertex{
		x:v.x * scalar,
		y:v.y * scalar,
		z:v.z * scalar
	}
}

pub fn (v &Vertex) cross (o &Vertex) Vertex {
	return Vertex{
		x: v.y * o.z - v.z * o.y,
		y: v.z * o.x - v.x * o.z,
		z: v.x * o.y - v.y * o.x
	}
}

pub fn (v &Vertex) normalize () Vertex{
	return v.div(v.length())
}

pub fn (v &Vertex) == (o &Vertex) bool {
	return v.x == o.x && v.y == o.y && v.z == o.z
}

pub fn (v &Vertex) < (o &Vertex) bool {
	return v.x < o.x && v.y < o.y && v.z < o.z
}

pub fn (v &Vertex) getx() f64 {
	return v.x
}

pub fn (v &Vertex) gety() f64 {
	return v.y
}

pub fn (v &Vertex) getz() f64 {
	return v.z
}

pub fn vertex_new(x f64, y f64, z f64) Vertex {
	return Vertex{
		x:x,
		y:y,
		z:z
	}
}

pub fn (v &Vertex) random (min f64, max f64) Vertex {
	return Vertex{
		x: min + (max - min) * rand.f64()
		y: min + (max - min) * rand.f64()
		z: min + (max - min) * rand.f64()
	}
}

pub fn (v &Vertex) near_zero () bool {
	s := 1.0 / 10000000
	return (math.abs(v.x) < s) && (math.abs(v.y) < s) && (math.abs(v.z) < s)
}

pub fn reflect (v &Vertex, n &Vertex) Vertex {
	return v - n.mul(2.0 * v.dot(n))
}

pub fn (v &Vertex) random_in_unit_sphere () Vertex {
	mut p := Vertex{0, 0, 0}
	for {
		p = p.random(-1.0, 1.0)
		if p.length_squared() < 1 {
			return p
		}
	}
	return p
}

pub fn (v &Vertex) str() string{
	return 'Vertex{x: $v.x, y: $v.y, z: $v.z}' 
}

pub fn (v &Vertex) refract (u &Vertex, fract f64) Vertex {
	cos_theta := math.min(-v.dot(u), 1.0)
	perp := (v + v.mul(cos_theta)).mul(fract)
	par := u.mul(-math.sqrt(math.abs(1.0 - perp.length_squared())))
	return perp + par
}