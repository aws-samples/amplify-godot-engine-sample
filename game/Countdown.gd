class_name Countdown
extends Label

signal timeout

@export var start_message: String = ""
@export var timeout_message: String = ""
@export var autostart := false
@export var count := 3
@export var delay := 1

@onready var timer: Timer = %Timer
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var _running = false

func start() -> void:
	_running = true
	visible = true
	text = str(count)
	timer.start(delay)

func stop() -> void:
	_running = false

func _ready() -> void:
	text = start_message
	timer.timeout.connect(_on_timeout)
	if autostart:
		start()

func _exit_tree() -> void:
	timer.timeout.disconnect(_on_timeout)

func _on_timeout() -> void:
	if _running:
		count = count - 1
		if count == 0:
			timer.stop()
			if timeout_message:
				text = timeout_message
			else:
				text = str(count)
			animation_player.play("fade_out")
			timeout.emit()
		else:
			text = str(count)
