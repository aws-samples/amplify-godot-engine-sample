class_name ProfileButton
extends Button

signal profile_selected

var data: GameGenres.GenreData

@onready var label: Label = %Label
@onready var image: TextureRect = %Image

func _ready() -> void:
	label.text = data.name
	image.texture = load(data.icons[0])
	
func _on_pressed() -> void:
	profile_selected.emit(data)
