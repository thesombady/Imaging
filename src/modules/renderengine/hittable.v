module renderengine

import mathengine {Vertex}

pub struct Hit_Record {
pub mut: point Vertex
	normal Vertex
	material Material 
	t f64
	front_face bool
}

pub fn (mut record Hit_Record) set_face_normal (ray Ray, outward_normal Vertex) {
	record.front_face = ray.direction.dot(outward_normal) < 0
	record.normal = if record.front_face {outward_normal} else {outward_normal.mul(-1)}
}

// Generic struct for hittable objects
pub struct Hittable_List {
pub mut: objects []Sphere
}

pub fn (list &Hittable_List) hit (ray &Ray, t_min f64, t_max f64, mut record &Hit_Record) bool {
	mut temp_record := Hit_Record{}
	mut hit_anything := false
	mut closest_so_far := t_max
	for object in list.objects{
		if object.hit(ray, t_min, closest_so_far, mut temp_record) {
			hit_anything = true
			closest_so_far = temp_record.t
			record = temp_record
		}
	}
	return hit_anything
}

