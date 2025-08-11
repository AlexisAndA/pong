package main

import "app"

main :: proc() {
	window := app.new_window("Pong")
	defer app.delete_window(window)

	game := app.init_game()

	music := app.load_music("assets/music.wav")
	defer app.unload_music(music)
	app.play_music(music)

	for !app.window_should_close(window) {
		app.update_music(music)

		delta_time := app.get_delta_time(window)

		app.process_game(&game, delta_time)

		app.draw_game(game)
	}	
}
