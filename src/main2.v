import mathengine {Vertex, Triangle, Mesh}
import renderengine {makeppm, Lambertian, Metal}
//import audioengine {play_sound}

/*
The main class of the game. This class is responsible for the main loop of the game.
*/


pub fn renderloop(){
	quit := false
	for !quit {
		// update the camera (the user inputs are handled here)

		// update the scene elements (the physics are handled here)

		// render the scene (the rendering is handled here)

		// swap buffers (the buffers are swapped here)

	}
}
makeppm('test.ppm', 1200)!


