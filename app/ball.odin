package app

import "core:fmt"

Vec2 :: distinct [2]f32


Ball :: distinct struct {
	sprite: Sprite,
	rect:     Rect,
	velocity: Vec2,
}

new_ball :: proc() -> Ball {
	return Ball {
		sprite = load_sprite("assets/ball.png"),
		rect = {x = 640 / 2 - 20, y = 480 / 2 - 20, width = 20, height = 20},
		velocity = {1, -1},
	}
}

apply_ball_velocity :: proc(ball: ^Ball, delta_time: f32) {
	ball.rect.x += ball.velocity.x * 400 * delta_time
	ball.rect.y += ball.velocity.y * 400 * delta_time
}

handle_ball_collision :: proc(ball: ^Ball, players: [2]Rect) {
	if ball.rect.y > (360 - ball.rect.height) do ball.velocity.y *= -1
	if ball.rect.y < 0 do ball.velocity.y *= -1

	for player in players {
		if check_collision(ball.rect, player) {
			ball.velocity.x *= -1
		}
	}
}

draw_ball :: proc(ball: Ball) {
	draw_sprite(ball.sprite, i32(ball.rect.x), i32(ball.rect.y))
}

reset_ball :: proc(ball: ^Ball) {
	ball.rect = {
		x      = 640 / 2 - 20,
		y      = 480 / 2 - 20,
		width  = 20,
		height = 20,
	}
	ball.velocity = {1, -1}
}