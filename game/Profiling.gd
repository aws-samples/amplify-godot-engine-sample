class_name Profiling
extends Node

const PRFILE_BUTTON = preload("res://ProfileButton.tscn")

@onready var _ai_chat = $AiChat
@onready var welcome: Label = $Welcome
@onready var question_1: Label = $Question1
@onready var answer_1: GridContainer = $Answer1
@onready var answer_2: LineEdit = $Answer2
@onready var enter: Button = $Enter

var _ai_chat_richtextlabel: RichTextLabel
var _ai_chat_textedit: TextEdit
var _ai_chat_text_button: Button 
var _loading_animation_timer: Timer
var _dots_count: int = 0
var _is_loading: bool = false

var player_name: String = ""
var current_focused_button: Node = null

func _ready() -> void:
	player_name = generate_pirate_name()
	GlobalData.player_name = player_name
	welcome.text = generate_welcome()
	
	var first_button = null
	for type in game_genres.genres:
		var profile_button = PRFILE_BUTTON.instantiate()
		profile_button.data = game_genres.genres[type]
		profile_button.profile_selected.connect(_on_profile_selected)
		profile_button.mouse_entered.connect(_on_button_mouse_entered.bind(profile_button))
		profile_button.gui_input.connect(_on_button_key_pressed.bind(profile_button))
		answer_1.add_child(profile_button)
		
		# Store the first button
		if first_button == null:
			first_button = profile_button

	# Instead of random selection, focus the first button
	if first_button:
		current_focused_button = first_button
		first_button.grab_focus()
	
	# Store the initial focused button
	# current_focused_button = answer_1.get_children()[randi_range(0, game_genres.genres.size()-1)]
	print(current_focused_button)
	current_focused_button.grab_focus()

	# AIChat
	_ai_chat.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_ai_chat_textedit = _ai_chat.get_node("CanvasGroup/TextEdit")
	_ai_chat_richtextlabel = _ai_chat.get_node("CanvasGroup/RichTextLabel")
	_ai_chat_text_button = _ai_chat.get_node("CanvasGroup/Button")
	
	var _example_questions = """[color=yellow]
	Braak! Ask me some of these questions!\n
	- What is the game about?\n
	- How do I play the game?\n
	- How can I win?
	[/color]"""
	_ai_chat_richtextlabel.append_text(_example_questions)

	_ai_chat.get_node("CanvasGroup").hide()
	var ai_chat_button = _ai_chat.get_node("TextureButton")
	ai_chat_button.show()
	ai_chat_button.connect("button_down", _on_chat_ai_button_pressed)
	
	# Connect the text button to send chat messages
	_ai_chat_text_button.connect("pressed", _on_chat_text_button_pressed)
	
	# Connect TextEdit to handle Enter key
	_ai_chat_textedit.gui_input.connect(_on_chat_textedit_gui_input)
	
	_ai_chat.get_node("RichTextLabel").show()
	
	_setup_loading_animation()

func _on_button_mouse_entered(button: Node) -> void:
	_handle_button_focus(button)

func _on_button_key_pressed(event: InputEvent, button: Node) -> void:
	if event is InputEventKey:
		if event.pressed and (event.keycode == KEY_ENTER or event.keycode == KEY_SPACE):
			_handle_button_focus(button)
	
func _handle_button_focus(button: Node) -> void:
	print(button)
	if current_focused_button and current_focused_button != button:
		current_focused_button.release_focus()
	current_focused_button = button
	button.grab_focus()

# Function to handle Enter key press in TextEdit
func _on_chat_textedit_gui_input(event: InputEvent) -> void:
	# Check if the event is a key press
	if event is InputEventKey and event.pressed:
		# Check if Enter key is pressed (without Shift key)
		if event.keycode == KEY_ENTER and not event.shift_pressed:
			# Prevent the normal Enter key behavior (adding a newline)
			get_viewport().set_input_as_handled()
			# Send the chat message using the existing function
			_on_chat_text_button_pressed()

func _on_profile_selected(data):
	game_genres.selected_genre = data
	
	ad_image_generator.generate_image(
		game_genres.selected_genre.prompt,
		game_genres.selected_genre.negative_prompt,
		[], #[Color.FIREBRICK],
		576, 
		1024, 
		6,
		randi()
	)
	question_1.visible = false
	answer_1.visible = false
	
	get_parent().change_scene("res://Game.tscn")

func _on_text_changed(_new_text: String) -> void:
	if answer_2.text.length() > 0:
		enter.disabled = false
		
func _on_button_pressed() -> void:
	get_parent().change_scene("res://Game.tscn")
		
func _on_chat_ai_button_pressed() -> void:
	if _ai_chat.get_node("CanvasGroup").visible:
		_ai_chat.get_node("CanvasGroup").hide()
		_ai_chat.get_node("RichTextLabel").show()
		current_focused_button.grab_focus()
	else:
		_ai_chat.get_node("CanvasGroup").show()
		_ai_chat.get_node("RichTextLabel").hide()

func _on_chat_text_button_pressed() -> void:
	# Get the user's input text
	var user_text = _ai_chat_textedit.text.strip_edges()
	
	# Don't process empty messages
	if user_text.is_empty():
		return
	
	# Clear the input field for next message
	_ai_chat_textedit.text = ""
	
	# Generate AI response
	_generate_ai_chat(user_text)

func _generate_ai_chat(prompt: String):
	_start_loading_animation()
	
	var query = """
	GenAiChat(prompt: "%s")
	""" % prompt
	
	var response = await aws_amplify.data.query(query, "GenAiChat")
	
	_stop_loading_animation()
	
	if response.result and response.result.has("data"):
		var json_response = JSON.parse_string(response.result.data["GenAiChat"])
		
		if json_response and json_response.has("statusCode") and json_response.statusCode == 200:
			var answer = json_response.body.answer
			
			# Add original propt
			_ai_chat_richtextlabel.append_text("\nYou: " + prompt + "\n")
			# Update the text display with AI response
			_ai_chat_richtextlabel.append_text("\n[color=yellow]Graak! " + answer + "[/color]")
			# Scroll to the bottom to show latest message
			_ai_chat_richtextlabel.scroll_to_line(0)

		else:
			print("Error: Unexpected AI response format.")
			# _ai_chat_richtextlabel.append_text("\nError: Could not generate AI response.")
	else:
		print("Error retrieving AI chat: " + str(response.error))
		# _ai_chat_richtextlabel.append_text("\nError: Could not connect to AI service.")

func _setup_loading_animation() -> void:
	_loading_animation_timer = Timer.new()
	_loading_animation_timer.wait_time = 0.5
	_loading_animation_timer.connect("timeout", _update_loading_animation)
	add_child(_loading_animation_timer)

func _start_loading_animation() -> void:
	_is_loading = true
	_dots_count = 0
	_loading_animation_timer.start()
	# Add the initial message
	_ai_chat_richtextlabel.text += "Braak! Polly getting a cracker!!"

func _stop_loading_animation() -> void:
	_is_loading = false
	_loading_animation_timer.stop()
	# Remove the loading message
	var current_text = _ai_chat_richtextlabel.text
	var loading_message = "Braak! Polly getting a cracker!!"
	
	# Find the position of the loading message
	var message_pos = current_text.find(loading_message)
	if message_pos != -1:
		# Remove the loading message and any dots that might have been added
		_ai_chat_richtextlabel.text = current_text.substr(0, message_pos)

func _update_loading_animation() -> void:
	if not _is_loading:
		return
			
	_dots_count = (_dots_count + 1) % 4
	var current_text = _ai_chat_richtextlabel.text
	
	# Remove any existing dots
	while current_text.ends_with("."):
		current_text = current_text.substr(0, current_text.length() - 1)
		
	# Add new dots
	_ai_chat_richtextlabel.text = current_text + ".".repeat(_dots_count)

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
