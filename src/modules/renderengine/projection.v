module renderengine
import mathengine {Vertex, Matrix, Triangle, Mesh}
import math


/* A projection function that takes in a vertex; vertex{1,2,3} and returns a tuple/array of the 
the projection coordinates in terms of x and y, derived from x,y,z. It computes the projection
with perspective projection and rely on the fact that the z-component is the depth of the mesh.
*/

pub fn projection(v &Vertex, camera &Vertex, phi &Vertex, evector &Vertex) (f64, f64){
	// returns the 2d projections of a 3d vertex
	pos := unsafe{v - camera}
	x := math.cos(phi.y) * (math.sin(phi.z) * pos.y + math.cos(phi.z) * pos.x) -math.sin(phi.y) * pos.z
	y := math.sin(phi.x) * (math.cos(phi.y) * pos.z + math.sin(phi.y) * (math.sin(phi.z) * pos.y + math.cos(phi.z) * pos.x)) + math.cos(phi.x) * (math.cos(phi.z) * pos.y - math.sin(phi.z) * pos.x)
	z := math.cos(phi.x) * (math.cos(phi.y) * pos.z + math.sin(phi.y) * (math.sin(phi.z) * pos.y + math.cos(phi.z) * pos.x)) - math.sin(phi.x) * (math.cos(phi.z) * pos.y - math.sin(phi.z) * pos.x)
	conversion := evector.div(z)
	return x * conversion.getx() + evector.getx(), y * conversion.gety() + evector.gety()
}
/*
mut evector := Vertex{100.0, 100.0, 100.0} // the maximum one can view in all directions
mut phi := Vertex{0.0, 0.0, 0.0} // the angle of the camera 
mut camera := Vertex{0.0, 0.0, -5.0} // the position of the camera
*/

pub fn render_triangle(t &Triangle, camera &Vertex, phi &Vertex, evector &Vertex) {
	// renders a single triangle
	vec1, vec2, vec3 := t.get_vertices()
	normal := (vec3 - vec1).cross(vec2 - vec1).normalize()
	/*
	proj1x, proj1y := projection(vec1, camera, phi, evector)
	proj2x, proj2y := projection(vec2, camera, phi, evector)
	proj3x, proj3y := projection(vec3, camera, phi, evector)	
	*/
}