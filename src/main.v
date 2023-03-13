import ui
import gg
import gx
import os
import mathengine {Vertex, Triangle, Mesh}


const(
	win_height = 800
	win_width = 800
	nr_cols = 4
	cell_height = 25
	cell_width = 100
	table_width = nr_cols * cell_width
)


[heap]
struct State {
mut:
	object_name string
	data &Mesh
	window &ui.Window = unsafe {nil}
	is_error bool
	started bool
}

fn main (){
	mut logo:= os.resource_abs_path("Lysander.ico")
	$if windows{
		logo = 'Lysander.ico'
	}
	mut app := &State{}
	window := ui.window(
		width: win_width
		height: win_height
		title: "LysanderV"
		mode: .resizable
		children : [
			/*
			ui.picture(
				width: 50
				height: 50
				path : logo
			)
			*/
			ui.row(
				margin: ui.Margin{10, 10, 10, 10}
				spacing: 10
				children: [
					ui.column(
						spacing: 13
						children: [
							ui.label(
								text: "LysanderV Game Engine"
							)
						]
					)
				]
			),
		]
	)
	app.window = window
	ui.run(window)
}