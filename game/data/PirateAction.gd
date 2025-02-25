class_name PirateAction
extends Resource

enum Id {
	APPLY,
	BACK,
	BROWSE,
	BUY,
	CANCEL,
	CLOSE,
	CONFIRM,
	JOIN,
	LOAD,
	MENU,
	NEXT,
	OPTIONS,
	PAUSE,
	QUIT,
	RESUME,
	RETRY,
	SAVE,
	SELL,
	START
}

@export var id: Id
@export var name: String
@export var description: String
@export var labels: Array[String]

func _init(p_id: Id = Id.CONFIRM,
		p_name: String = "",
		p_description: String = "",
		p_labels: Array[String] = []) -> void:

	id = p_id
	name = p_name
	description = p_description
	labels = p_labels

func get_random_label() -> String:
	return labels[randi() % labels.size()]

func _to_string() -> String:
	return "PirateAction(%s)" % name
