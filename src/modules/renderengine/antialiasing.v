module renderengine
import mathengine {Vertex}

import rand

pub fn random_double (min f64, max f64) f64 {
	// Returns a random value on the interval [min, max)
	return min + (max - min) * rand.f64()
}

pub fn clamp(x f64, min f64, max f64) f64 {
	if x <= min {
		return min
	}
	if x >= max {
		return max
	}
	return x
}