class_name Profiling
extends Node

const PRFILE_BUTTON = preload("res://ProfileButton.tscn")

@onready var welcome: Label = $Welcome
@onready var question_1: Label = $Question1
@onready var answer_1: GridContainer = $Answer1
@onready var answer_2: LineEdit = $Answer2
@onready var enter: Button = $Enter

var player_name: String = ""

func _ready() -> void:
	player_name = generate_pirate_name()
	GlobalData.player_name = player_name
	welcome.text = generate_welcome()
	for type in game_genres.genres:
		var profile_button = PRFILE_BUTTON.instantiate()
		profile_button.data = game_genres.genres[type]
		profile_button.profile_selected.connect(_on_profile_selected)
		answer_1.add_child(profile_button)
	answer_1.get_children()[0].grab_focus()

func _on_profile_selected(data):
	game_genres.selected_genre = data
	ad_image_generator.generate_image(data, randi(), 576, 1024, 6)
	question_1.visible = false
	answer_1.visible = false
	
	get_parent().change_scene("res://Game.tscn")

func _on_text_changed(_new_text: String) -> void:
	if answer_2.text.length() > 0:
		enter.disabled = false

func _on_button_pressed() -> void:
	get_parent().change_scene("res://Game.tscn")

# Pirate name generator

var famous_prefixes = [
	"Black",
	"Calico",
	"Long",
	"Bloody",
	"Mad",
	"One-Eyed",
	"Captain",
	"Salty",
	"Red",
	"Silver"
]

var famous_names = [
	"John", # From John Rackham
	"Jack", # From Jack Sparrow
	"Anne", # From Anne Bonny
	"Mary", # From Mary Read
	"Edward", # From Edward Teach (Blackbeard)
	"Bartholomew", # From Bartholomew Roberts
	"Henry", # From Henry Morgan
	"William", # From William Kidd
	"Francis", # From Francis Drake
	"Grace" # From Grace O'Malley
]

var pirate_surnames = [
	"Sparrow", # From Jack Sparrow
	"Teach", # From Blackbeard
	"Bonny", # From Anne Bonny
	"Roberts", # From Bartholomew Roberts
	"Morgan", # From Henry Morgan
	"Rackham", # From Calico Jack
	"Read", # From Mary Read
	"Silver", # From Long John Silver
	"Drake", # From Francis Drake
	"Flint" # From Captain Flint
]

var nicknames = [
	"the Fierce",
	"the Ruthless",
	"the Terror of the Seven Seas",
	"the Plunderer",
	"Deadshot",
	"the Privateer",
	"the Buccaneer",
	"the Dread",
	"the Bold",
	"Storm-Eye"
]

func generate_pirate_name() -> String:
	randomize()
	
	var use_prefix = randi() % 2 # 50% chance to use prefix
	var use_nickname = randi() % 2 # 50% chance to use nickname
	
	var name_parts = []
	
	if use_prefix:
		name_parts.append(famous_prefixes[randi() % famous_prefixes.size()])
	
	name_parts.append(famous_names[randi() % famous_names.size()])
	name_parts.append(pirate_surnames[randi() % pirate_surnames.size()])
	
	if use_nickname:
		name_parts.append(nicknames[randi() % nicknames.size()])
	
	return " ".join(name_parts)

# Greetings generator

var greetings = [
	"Ahoy",
	"Yarr",
	"Avast",
	"Yo-ho-ho",
	"Shiver me timbers"
]

var titles = [
	"ye scurvy dog",
	"matey",
	"me hearty",
	"ye landlubber",
	"ye swashbuckler",
	"ye sea dog"
]

var named_greetings = [
	"Welcome aboard, Captain {name}!",
	"If it ain't Captain {name}!",
	"Look who's sailed in - it's {name}!",
	"Well blow me down, it's {name}!",
	"Aye, {name} has returned!",
	"Make way for Captain {name}!"
]

var messages = [
	"Welcome aboard the {ship_name}!",
	"Set sail fer adventure!",
	"Prepare to sail the seven seas!",
	"May the wind be at yer back!",
	"There be treasure awaiting!",
	"The sea be callin' yer name!"
]

var ship_names = [
	"Black Pearl",
	"Flying Dutchman",
	"Queen Anne's Revenge",
	"Jolly Roger",
	"Royal Fortune",
	"Adventure Galley",
	"Whydah Gally"
]

var extras = [
	"Keep yer powder dry!",
	"Dead men tell no tales!",
	"Raise the Jolly Roger!",
	"Fair winds or foul, we sail!",
	"X marks the spot!",
	"Drink up, me hearties!"
]

func generate_welcome() -> String:
	randomize()
	
	var message_parts = []
	
	# Personalized greeting with name
	if randi() % 2:
		# Use named greeting format
		var named_greeting = named_greetings[randi() % named_greetings.size()]
		message_parts.append(named_greeting.replace("{name}", player_name))
	else:
		# Use standard greeting with name
		message_parts.append(greetings[randi() % greetings.size()])
		message_parts.append("Captain " + player_name)
		message_parts.append("!")
	
	# Add main message
	var main_message = messages[randi() % messages.size()]
	if "{ship_name}" in main_message:
		main_message = main_message.replace("{ship_name}", ship_names[randi() % ship_names.size()])
	message_parts.append(main_message)
	
	# 50% chance to add extra phrase
	if randi() % 2:
		message_parts.append(extras[randi() % extras.size()])
	
	return " ".join(message_parts)
