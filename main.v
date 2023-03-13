// module main

import vec {Vec4d}
/*
type Color = Vec4d

pub fn (c &Color) str () string {
	return "Color ($c.x, $c.y, $c.z, $c.w)"
}
*/

type Object = Sphere|Box|Circle|Cylinder

struct Sphere{
	pub:
		center f64 = 0.0
}

struct Box{

}

struct Circle{

}

struct Cylinder{

}

pub struct List {
	pub: data Object
}




fn main() {
	mut c := []List{}
	c << List{data: Sphere{}}
	c << List{data: Box{}}
	c << List{data: Circle{}}
	c << List{data: Cylinder{}}
	for obj in c {
		match obj.data {
			Sphere {
				println('sphere')
			}
			Box {
				println('box')
			}
			Circle {
				println('circle')
			}
			Cylinder {
				println('cylinder')
			}
		}
	}
}

