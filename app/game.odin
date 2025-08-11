package app

import rl "vendor:raylib"

GameState :: enum {
	Main_Menu,
	Game,
}

Game :: struct {
	game_state: GameState,
	game_score: GameScore,
	ball: Ball,
	players: [2]Rect
}

init_game :: proc() -> Game {
	game := Game { game_state = GameState.Main_Menu, game_score = GameScore {}, ball = new_ball(), players = [2]Rect{{0, 10, 1, 95}, {640 - 1, 10, 1, 95}} }
	return game
}

process_game :: proc(game: ^Game, delta_time: f32) {
	switch game.game_state {
		case GameState.Main_Menu:
			if rl.IsGamepadButtonPressed(0, rl.GamepadButton.MIDDLE_RIGHT) do game.game_state = GameState.Game
		case GameState.Game:
			game.players[0].y += rl.GetGamepadAxisMovement(0, rl.GamepadAxis.LEFT_Y) * 1000 * delta_time
			game.players[0].y = clamp(game.players[0].y, 10, 360 - 10 - 95)

			game.players[1].y +=
				rl.GetGamepadAxisMovement(0, rl.GamepadAxis.RIGHT_Y) * 1000 * delta_time
			game.players[1].y = clamp(game.players[1].y, 10, 360 - 10 - 95)

			apply_ball_velocity(&game.ball, delta_time)
			handle_ball_collision(&game.ball, game.players)

			if game.ball.rect.x < 0 - game.ball.rect.width {
				game.game_score.second_player_score += 1

				reset_ball(&game.ball)

				// The second person has scored. We want the first person to move first.
				game.ball.velocity = {-1, 1}
			}

			if game.ball.rect.x > 640 {
				game.game_score.first_player_score += 1

				reset_ball(&game.ball)
			}
	}
}

draw_game :: proc(game: Game) {
	rl.BeginDrawing()

	rl.ClearBackground(rl.BLACK)

	switch game.game_state {
		case GameState.Main_Menu:
			rl.DrawText(
				"Press Start!",
				(640 / 2) - rl.MeasureText("Press Start!", 25) / 2,
				360 / 2,
				25,
				rl.RED,
			)
		case GameState.Game:
			for player in game.players {
				draw_rect(player)
			}
			draw_ball(game.ball)
			draw_game_score(game.game_score)

		}
	rl.EndDrawing()
}