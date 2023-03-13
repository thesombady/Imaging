module renderengine
import os
import math
import mathengine {Vertex}


pub fn ray_color(r &Ray, world &Hittable_List, depth int) Vertex {
	mut record := Hit_Record{}

	// Bounce limit
	if depth <= 0 {
		return Vertex{x: 0.0, y: 0.0, z: 0.0}
	}
	// testing if the ray hits an object
	if world.hit(r, 0.001, math.max_f64, mut record) {
		mut scattered := Ray{}
		mut attenuation := Vertex{}
		if scatter(record.material, r, mut record, mut attenuation, mut scattered) {
			return attenuation * ray_color(&scattered, world, depth - 1)
		} else{
			return Vertex{x: 0.0, y: 0.0, z: 0.0}
		}
		}
	// Background
	unit_direction := r.direction.normalize()
	t := 0.5 * (unit_direction.y + 1.0)
	return Vertex{x: 1.0, y: 1.0, z: 1.0}.mul(1.0 - t) + Vertex{x: 0.5, y: 0.7, z: 1.0}.mul(t)
}


pub fn makeppm(path string, width int)! {
	// Image
	aspect_ratio := 3.0/2.0
	image_width := width
	image_height := int(image_width / aspect_ratio)
	samples_per_pixel := 200
	max_depth := 25 // number of bounces

	// Scene

	mut world := Hittable_List{}

	world.objects << Sphere{center: Vertex{x: 0.0, y: -100.5, z: -1.0}, radius: 100.0, material: Material{lambertian: true, albedo: Vertex{x: 0.8, y: 0.8, z: 0.0}}}

	for a := 0; a < 11; a++ {
		for b := 0; b < 3; b ++ {
			material_choice := random_double(0.0, 1.0)
			center := Vertex{a + 0.9 * random_double(0.0, 1.0), 0.2, b + random_double(0.0, 1.0)}
			if (center - Vertex{4.0, 0.2, 0}).length() > 0.9{
				if material_choice < 0.8 {
					// Diffuse
					albedo := Vertex{}.random_in_unit_sphere()
					world.objects << Sphere{center: center, radius: 0.2, material: Material{lambertian: true, albedo: albedo}}
				} else if material_choice < 0.95 {
					// Metal
					albedo := Vertex{}.random(0.5, 1.0)
					fuzz := random_double(0.0, 0.5)
					world.objects << Sphere{center: center, radius: 0.2, material: Material{metal: true, albedo: albedo, fuzz: fuzz}}
				} else {
					// Glass
					world.objects << Sphere{center: center, radius: 0.2, material: Material{dialectric: true, albedo: Vertex{x: 1.0, y: 1.0, z: 1.0}, index_refraction: 1.5}}
				}
			}
		}
	}
	// Making the bigger spheres 
	world.objects << Sphere{center: Vertex{x: 0.0, y: 1.0, z: 0.0}, radius: 1.0, material: Material{dialectric: true, albedo: Vertex{x: 1.0, y: 1.0, z: 1.0}, index_refraction: 1.5}}

	world.objects << Sphere{center: Vertex{x: -4.0, y: 1.0, z: 0.0}, radius: 1.0, material: Material{lambertian: true, albedo: Vertex{x: 0.4, y: 0.2, z: 0.1}}}

	world.objects << Sphere{center: Vertex{x: 4.0, y: 1.0, z: 0.0}, radius: 1.0, material: Material{metal: true, albedo: Vertex{x: 0.7, y: 0.6, z: 0.5}, fuzz: 0.0}}

	// Camera
	camera := new_camera()
	
	// Making the file
	mut file := os.create(path)!
	// creating the header
	file.write_string('P3\n')! // PPM format
	file.write_string('$image_width $image_height\n')! // Image size
	file.write_string('255\n')! // Image factor'
	
	for j:= image_height; j >= 0; j-- {
		for i:= 0; i < image_width; i++ {
			mut color := Vertex{x: 0.0, y: 0.0, z: 0.0}
			for s := 0; s < samples_per_pixel; s++ {
				u := (f64(i) + random_double(0.0, 1.0)) / (image_width - 1)
				v := (f64(j) + random_double(0.0, 1.0)) / (image_height - 1)
				r := camera.get_ray(u, v)
				color += ray_color(r, world, max_depth)
			}
			file.write_string(write_color(color, samples_per_pixel))!
		}
		println('Scanlines remaining: $j')
	}
}