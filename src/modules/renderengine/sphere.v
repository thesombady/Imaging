module renderengine
import math

import mathengine {Vertex}

// should be generic type of material
pub struct Sphere {
pub:
	center Vertex
	radius f64
	material Material
}

pub fn (s Sphere) hit (ray Ray, t_min f64, t_max f64, mut record Hit_Record) bool {
	oc := ray.origin - s.center
	a := ray.direction.length_squared()
	half_b := oc.dot(ray.direction)
	c := oc.length_squared() - s.radius * s.radius

	discriminant := half_b * half_b - a * c
	if discriminant < 0 {
		return false
	}
	sqrtd := math.sqrt(discriminant)
	mut root := (-half_b - sqrtd) / a
	if root < t_min || t_max < root {
		root = (-half_b + sqrtd) / a
		if root < t_min || t_max < root {
			return false
		}
	}
	record.t = root
	record.point = ray.at(record.t)
	outward_normal := (record.point - s.center).div(s.radius)
	record.set_face_normal(ray, outward_normal) 
	record.material = s.material
	return true
}