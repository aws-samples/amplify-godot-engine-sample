class_name ProfileButton
extends Button

signal profile_selected

var genre: GameGenre

@onready var label: Label = %Label
@onready var image: TextureRect = %Image

func _ready() -> void:
	label.text = genre.display_name
	image.texture = load(genre.get_absolute_icon_paths()[0])
	
func _on_pressed() -> void:
	profile_selected.emit(genre)
