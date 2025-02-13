class_name Chat
extends Container

const CHAT_MESSAGE = preload("res://ChatMessage.tscn")

@onready var scroll: ScrollContainer = %Scroll
@onready var messages: VBoxContainer = %Messages
@onready var message: LineEdit = %Message

var max_scroll_length: int

func add_message(from: String, message: String, is_self: bool = true):
	var chat_message = CHAT_MESSAGE.instantiate()
	messages.add_child(chat_message)
	chat_message.initialize(from, message, is_self)
	
func _ready() -> void:
	var v_scroll_bar = scroll.get_v_scroll_bar()
	v_scroll_bar.changed.connect(_on_scroll_changed)
	max_scroll_length = v_scroll_bar.max_value
	message.grab_focus()
	
func _on_new_message() -> void:
	add_message("You", message.text)
	message.text = ""
	# send message to server here and wait for response
	# on responce
	add_message("Agent", "Agent Response", false)
	message.grab_focus()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_accept"):
		_on_new_message()

func _on_scroll_changed() -> void:
	var v_scroll_bar = scroll.get_v_scroll_bar()
	if max_scroll_length != v_scroll_bar.max_value: 
		max_scroll_length = v_scroll_bar.max_value 
		scroll.scroll_vertical = max_scroll_length	
