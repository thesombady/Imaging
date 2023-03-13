module renderengine

import mathengine {Vertex}


pub struct Camera{
pub mut: aspect_ratio f64
	viewport_height f64
	viewport_width f64
	focal_length f64
	origin Vertex
	horizontal Vertex
	vertical Vertex
	lower_left_corner Vertex
	lens_radius f64
	u Vertex
	v Vertex
}

pub fn new_camera() Camera{
	// Camera objectives
	look_from := Vertex{x: 13.0, y: 2.0, z: 3.0}
	look_at := Vertex{x: 0.0, y: 0.0, z: 0.0}
	vup := Vertex{x: 0.0, y: 1.0, z: 0.0}
	vfov := 90.0
	aperature := 0.1
	focus_dist := 10.0

	w := (look_from - look_at).normalize()
	u := vup.cross(w).normalize()
	v := w.cross(u)

	// Camera intrinsics
	aspect_ratio := 3.0 / 2.0
	viewport_height := 2.0
	viewport_width := aspect_ratio * viewport_height
	focal_length := 1.0
	origin := look_from
	horizontal := u.mul(viewport_width * focus_dist) 
	vertical := v.mul(viewport_height * focus_dist)
	lower_left_corner := origin - horizontal.div(2.0) - vertical.div(2.0) - w.mul(focus_dist)
	lens_radius := aperature / 2.0
	return Camera{
		aspect_ratio: aspect_ratio,
		viewport_height: viewport_height,
		viewport_width: viewport_width,
		focal_length: focal_length,
		origin: origin,
		horizontal: horizontal,
		vertical: vertical,
		lower_left_corner: lower_left_corner,
		lens_radius: lens_radius
		u: u,
		v: v
	}
}

pub fn (c Camera) get_ray (u f64, v f64) Ray {
	rd :=  Vertex{}.random_in_unit_sphere().mul(c.lens_radius)
	offset := c.u.mul(rd.x) + c.v.mul(rd.y)
	direction := c.lower_left_corner + c.horizontal.mul(u) + c.vertical.mul(v) - c.origin - offset
	return Ray{origin: c.origin, direction: direction}
}