package app

import "core:fmt"
import rl "vendor:raylib"

Music :: struct {
	stream: rl.Music
}

load_music :: proc(path: cstring) -> Music {
	if !rl.IsAudioDeviceReady() do rl.InitAudioDevice()

	stream := rl.LoadMusicStream(path)
	stream.looping = true
	return Music { stream = stream }
}

play_music :: proc(music: Music) {
	rl.PlayMusicStream(music.stream)
}

update_music :: proc(music: Music) {
	rl.UpdateMusicStream(music.stream)
}

unload_music :: proc(music: Music) {
	if rl.IsAudioDeviceReady() do rl.CloseAudioDevice()

	rl.UnloadMusicStream(music.stream)
}