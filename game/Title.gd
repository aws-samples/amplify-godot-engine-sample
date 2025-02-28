extends TextureRect

const PROFILING = "res://Profiling.tscn"

@onready var timer: Timer = $Timer
@onready var video: VideoStreamPlayer = $Video
@onready var speech: AudioStreamPlayer = $Speech
@onready var welcome: ColorRect = $Welcome
@onready var start: Button = $Welcome/Start
@onready var player: AnimationPlayer = $Player

func _ready() -> void:
	start.grab_focus()
	music_player.play(music_player.Themes.TITLE, 0)

func _on_start_pressed() -> void:
	music_player.audio_stream_player.volume_db = -10
	timer.start(5)
	video.play()
	speech.play()
	player.play("hide")

func _on_timer_timeout():
	music_player.audio_stream_player.volume_db = 0
	get_parent().change_scene(PROFILING, false)
