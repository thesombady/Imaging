module mathengine
import mathengine {Vertex}


pub struct Matrix {
	v1 Vertex
	v2 Vertex
	v3 Vertex
}


pub fn matrix_new(v1 Vertex, v2 Vertex, v3 Vertex) &Matrix {
	/*Simple constructor*/
	return &Matrix {
		v1: v1,
		v2: v2,
		v3: v3,
	}
}

pub fn matrix_new_identity() &Matrix {
	/*Identity matrix constructor*/
	return &Matrix {
		v1: vertex_new(1.0, 0.0, 0.0),
		v2: vertex_new(0.0, 1.0, 0.0),
		v3: vertex_new(0.0, 0.0, 1.0),
	}
}

pub fn scalar_mul (mat &Matrix, scalar f64) &Matrix {
	/*Scalar multiplication of a matrix*/
	return &Matrix {
		v1: vertex_new(mat.v1.x * scalar, mat.v1.y * scalar, mat.v1.z * scalar),
		v2: vertex_new(mat.v2.x * scalar, mat.v2.y * scalar, mat.v2.z * scalar),
		v3: vertex_new(mat.v3.x * scalar, mat.v3.y * scalar, mat.v3.z * scalar),
	}
}

pub fn vertex_mul(mat &Matrix, v &Vertex) &Vertex {
	/*Matrix multiplication of a vertex*/
	return &Vertex {
		x: mat.v1.x * v.x + mat.v1.y * v.y + mat.v1.x * v.z,
		y: mat.v2.x * v.x + mat.v2.y * v.y + mat.v2.y * v.z,
		z: mat.v3.x * v.x + mat.v3.y * v.y + mat.v3.z * v.z,
	}
}

pub fn (mat &Matrix) transpose() &Matrix {
	/*A function for retriving the transpose of a matrix*/
	return &Matrix {
		v1: vertex_new(mat.v1.x, mat.v2.x, mat.v3.x),
		v2: vertex_new(mat.v1.y, mat.v2.y, mat.v3.y),
		v3: vertex_new(mat.v1.z, mat.v2.z, mat.v3.z),
	}
}

pub fn matrix_mul (mat1 &Matrix, mat2 &Matrix) &Matrix {
	/*Matrix multiplication*/
	return &Matrix {
		v1: vertex_mul(mat1, mat2.transpose().v1),
		v2: vertex_mul(mat1, mat2.transpose().v2),
		v3: vertex_mul(mat1, mat2.transpose().v3)
	}
}