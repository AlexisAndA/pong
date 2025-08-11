package app

import "core:fmt"
import rl "vendor:raylib"

Sprite :: distinct struct {
	texture: rl.Texture2D
}

load_sprite :: proc(texture_path: cstring) -> Sprite {
	texture := rl.LoadTexture(texture_path)
	return Sprite { texture }
}

draw_sprite :: proc(sprite: Sprite, x: i32, y: i32) {
	rl.DrawTexture(sprite.texture, x, y, rl.WHITE)
}