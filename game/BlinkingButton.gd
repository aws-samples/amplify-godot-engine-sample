class_name BlinkingButton
extends Button

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	grab_focus()

func _on_focus_entered() -> void:
	animation_player.play("blink")

func _on_focus_exited() -> void:
	#print("FOCUS LOST")
	animation_player.stop()
