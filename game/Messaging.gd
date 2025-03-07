class_name Messaging
extends Label

signal timout

@export var autostart := false
@export var delay := 3

@onready var timer: Timer = %Timer
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func display(p_message: String, p_delay: int = delay) -> void:
	text = p_message
	visible = true
	timer.start(p_delay)
	
func _ready() -> void:
	if autostart:
		visible = true
		timer.start(delay)
	
func _on_timer_timeout() -> void:
	animation_player.play("fade_out")
	
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	timout.emit()
