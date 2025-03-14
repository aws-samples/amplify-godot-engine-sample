class_name MusicPlayer
extends Node

const PIRATES_VS_SHARKS_8_BIT_BUCCANEE = preload("res://art/musics/Pirates vs Sharks - 8-Bit Buccanee.mp3")
const PIRATES_VS_SHARKS_FIRE_BEACH_1 = preload("res://art/musics/Pirates vs Sharks - Fire Beach 1.mp3")
const PIRATES_VS_SHARKS_FIRE_BEACH_2 = preload("res://art/musics/Pirates vs Sharks - Fire Beach 2.mp3")
const PIRATES_VS_SHARKS_HIGH_SEAS_1 = preload("res://art/musics/Pirates vs Sharks - High Seas 1.mp3")
const PIRATES_VS_SHARKS_HIGH_SEAS_2 = preload("res://art/musics/Pirates vs Sharks - High Seas 2.mp3")
const PIRATES_VS_SHARKS_KINGS_OF_THE_WORLD_1 = preload("res://art/musics/Pirates vs Sharks - Kings of the World 1.mp3")
const PIRATES_VS_SHARKS_KINGS_OF_THE_WORLD_2 = preload("res://art/musics/Pirates vs Sharks - Kings of the World 2.mp3")
const PIRATES_VS_SHARKS_PIXEL_ADVENTURE_1 = preload("res://art/musics/Pirates vs Sharks - Pixel Adventure 1.mp3")
const PIRATES_VS_SHARKS_PIXEL_ADVENTURE_2 = preload("res://art/musics/Pirates vs Sharks - Pixel Adventure 2.mp3")
const PIRATES_VS_SHARKS_REEF_RUMBLE_1 = preload("res://art/musics/Pirates vs Sharks - Reef Rumble 1.mp3")
const PIRATES_VS_SHARKS_REEF_RUMBLE_2 = preload("res://art/musics/Pirates vs Sharks - Reef Rumble 2.mp3")

enum Themes {
	TITLE, LOOP, COMMERCIAL, CREDITS
}

var Streams = {
	Themes.TITLE: [PIRATES_VS_SHARKS_8_BIT_BUCCANEE, PIRATES_VS_SHARKS_PIXEL_ADVENTURE_1, PIRATES_VS_SHARKS_PIXEL_ADVENTURE_2],
	Themes.LOOP: [PIRATES_VS_SHARKS_REEF_RUMBLE_1, PIRATES_VS_SHARKS_KINGS_OF_THE_WORLD_2],
	Themes.COMMERCIAL: [PIRATES_VS_SHARKS_REEF_RUMBLE_2, PIRATES_VS_SHARKS_KINGS_OF_THE_WORLD_1],
	Themes.CREDITS: [PIRATES_VS_SHARKS_FIRE_BEACH_1, PIRATES_VS_SHARKS_FIRE_BEACH_2, PIRATES_VS_SHARKS_HIGH_SEAS_1, PIRATES_VS_SHARKS_HIGH_SEAS_2],
}
	
signal activated
signal deactivated

var _active = false

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

func is_active():
	return _active

func set_active(p_active, no_signal = false):
	_active = p_active
	if not no_signal:
		if _active:
			audio_stream_player.play()
			activated.emit()
		else:
			audio_stream_player.stop()
			deactivated.emit()
		
func play(p_theme = Themes.TITLE, p_index = -1):
	var streams = Streams[p_theme]
	var index = p_index
	if index < 0 or index >= streams.size() -1:
		index = randi_range(0, streams.size()-1)
	audio_stream_player.stream = streams[index] 
	 
	if _active:
		audio_stream_player.play()
	
func stop():
	audio_stream_player.stop()
