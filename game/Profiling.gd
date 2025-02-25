class_name Profiling
extends Node

const PRFILE_BUTTON = preload("res://ui/ProfileButton.tscn")

@onready var welcome: RichTextLabel = %Welcome
@onready var question_1: Label = %Question1
@onready var answer_1: GridContainer = %Answer1
@onready var answer_1bis: LineEdit = %Answer1Bis
@onready var enter: Button = $Enter

func _ready() -> void:
	GameGlobals.region = PirateRegion.CARIBBEAN_SEA
	GameGlobals.nationality = PirateNationality.ENGLISH
	GameGlobals.base = PirateBase.ALL_BASES[GameGlobals.region.bases[0]]
	GameGlobals.water = PirateWater.ALL_WATERS[GameGlobals.region.waters[0]]
	GameGlobals.captain_name = PirateCaptainName.generate(GameGlobals.nationality, GameGlobals.base)
	GameGlobals.ship_name = PirateShipName.generate(GameGlobals.nationality, GameGlobals.water)
	GameGlobals.parrot_name = PirateParrotName.generate(true, true, true)
	welcome.text = PirateWelcomeMessage.generate(GameGlobals.region, GameGlobals.captain_name, GameGlobals.ship_name, GameGlobals.parrot_name)
	
	var genres = GameGenre.HISTORIAL_GENRES
	for genre in genres:
		var profile_button = PRFILE_BUTTON.instantiate()
		profile_button.genre = genre
		profile_button.profile_selected.connect(_on_profile_selected)
		answer_1.add_child(profile_button)
		
	answer_1.get_children()[randi_range(0, genres.size()-1)].grab_focus()

func _on_profile_selected(genre):
	GameGlobals.genre = genre
	var prompt = PirateCommercialPrompt.generate(genre, GameStyle.REALISTIC_3D, GameGlobals.region, GameGlobals.color)
	ad_image_generator.generate_image(prompt.prompt, prompt.negative_prompt, prompt.color_palette, randi(), 576, 1024, 6)
	question_1.visible = false
	answer_1.visible = false
	
	get_parent().change_scene("res://Game.tscn")

func _on_text_changed(_new_text: String) -> void:
	if answer_1bis.text.length() > 0:
		enter.disabled = false

func _on_button_pressed() -> void:
	get_parent().change_scene("res://Game.tscn")
