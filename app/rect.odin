package app

import rl "vendor:raylib"

Rect :: distinct struct {
	x:      f32,
	y:      f32,
	width:  f32,
	height: f32,
}

draw_rect :: proc(rect: Rect) {
	rl.DrawRectangle(i32(rect.x), i32(rect.y), i32(rect.width), i32(rect.height), rl.WHITE)
}

check_collision :: proc(first_rect: Rect, second_rect: Rect) -> bool {
	return(
		first_rect.x < second_rect.x + second_rect.width &&
		first_rect.x + second_rect.width > second_rect.x &&
		first_rect.y < second_rect.y + second_rect.height &&
		first_rect.y + first_rect.height > second_rect.y \
	)
}
