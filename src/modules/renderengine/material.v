module renderengine

import mathengine {Vertex, reflect}

pub struct Material {
pub mut: metal bool
	lambertian bool
	dialectric bool
	albedo Vertex
	fuzz f64 = 1.0
	index_refraction f64 = 1.0
}


pub struct Lambertian{
pub mut: albedo Vertex
}

pub struct Metal{
pub mut: albedo Vertex
	fuzz f64 = 1.0
}

pub struct Dialectric{
pub mut: index_refraction f64 = 1.0
}


pub fn scatter (object Material, ray_in &Ray, mut record &Hit_Record, mut attenuation &Vertex, mut scattered &Ray) bool {
	if object.lambertian{ 
		mut scatter_direction := record.normal + Vertex{}.random_in_unit_sphere()
		if scatter_direction.near_zero() {
			scatter_direction = record.normal
		}
		scattered = Ray{record.point, scatter_direction}
		attenuation = object.albedo
		return true
	}
	else if object.metal {
		reflected := reflect(ray_in.direction.normalize(), record.normal)
		scattered = Ray{origin: record.point, direction: reflected + Vertex{}.random_in_unit_sphere().mul(object.fuzz)}
		attenuation = object.albedo
		return scattered.direction.dot(record.normal) > 0
	} 
	else if object.dialectric{
		attenuation = Vertex{1.0, 1.0, 1.0}
		ratio_refraction := if record.front_face {1.0 / object.index_refraction} else {object.index_refraction}
		unit_direction := ray_in.direction.normalize()
		refracted := unit_direction.refract(record.normal, ratio_refraction)
		scattered = Ray{origin: record.point, direction: refracted}
		return true
	} else {
		return false
	}
	return false
}