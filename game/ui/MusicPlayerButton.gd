class_name MusicPlayerButton
extends HBoxContainer

@onready var check_button: CheckButton = %CheckButton

func _ready() -> void:
	check_button.set_pressed_no_signal(music_player.is_active())
	music_player.activated.connect(_on_music_player_activated)
	music_player.deactivated.connect(_on_music_player_deactivated)
	
func _exit_tree() -> void:
	music_player.activated.disconnect(_on_music_player_activated)
	music_player.deactivated.disconnect(_on_music_player_deactivated)
	
func _on_check_button_toggled(toggled_on: bool) -> void:
	music_player.set_active(toggled_on)
	
func _on_music_player_activated():
	check_button.set_pressed_no_signal(true)

func _on_music_player_deactivated():
	check_button.set_pressed_no_signal(false)
