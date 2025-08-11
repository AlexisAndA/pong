package app

import "core:fmt"
import rl "vendor:raylib"

Window :: distinct struct {
	title: string,
	width: i32,
	height: i32,
}

new_window :: proc(title: string, width: i32 = 640, height: i32 = 360) -> Window {
	title_cstring := fmt.ctprint("", title)
	rl.InitWindow(width, height, title_cstring) 

	window := Window {
		title = title,
		width = width,
		height = width
	}

	return window
}

window_should_close :: proc(window: Window) -> bool {
	return rl.WindowShouldClose()
}

get_delta_time :: proc(window: Window) -> f32 {
	return rl.GetFrameTime()
}

delete_window :: proc(window: Window) {
	rl.CloseWindow()
}