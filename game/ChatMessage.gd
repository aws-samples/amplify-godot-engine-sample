class_name ChatMessage
extends Container

const CHAT_MESSAGE_SELF = preload("res://chat_message_self.tres")
const CHAT_MESSAGE_OTHER = preload("res://chat_message_other.tres")

@onready var from_self: Label = %FromSelf
@onready var message: Label = %Message
@onready var from_other: Label = %FromOther

func initialize(p_from: String = "", p_message: String = "", is_self: bool = true) -> void:
	
	message.text = p_message
		
	if is_self:
		from_self.visible = true
		from_self.text = p_from
		message.add_theme_stylebox_override('normal', CHAT_MESSAGE_SELF)
		from_other.visible = false
	else:
		from_self.visible = false
		message.add_theme_stylebox_override('normal', CHAT_MESSAGE_OTHER)
		from_other.visible = true
		from_other.text = p_from
