package app

import "core:fmt"
import rl "vendor:raylib"

// This struct represents the game's score for the players.
GameScore :: struct {
	first_player_score:  u32,
	second_player_score: u32,
}

draw_game_score :: proc(game_score: GameScore) {
	// We have to convert the strings to cstrings to display them.
	first_player_score := fmt.ctprint("", game_score.first_player_score)
	first_player_score_size := rl.MeasureText(first_player_score, 50)

	second_player_score := fmt.ctprint("", game_score.second_player_score)
	second_player_score_size := rl.MeasureText(first_player_score, 50)

	rl.DrawText(first_player_score, 640 / 4 - first_player_score_size, 20, 50, rl.RED)	
	rl.DrawText(second_player_score, 640 / 4 * 3 - second_player_score_size, 20, 50, rl.RED)
}