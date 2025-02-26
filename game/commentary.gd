extends Control

@onready var rich_text: RichTextLabel = $RichTextLabel
@onready var parrot: TextureRect = $TextureRect
@onready var dialogbox: TextureRect = $DialogBox
@onready var game: Node = null
@onready var on_screen_timer: Timer = Timer.new()
@onready var off_screen_timer: Timer = Timer.new()

func _ready():
	
	# Ensure everything is hidden initially
	hide_elements()
	
	rich_text.bbcode_enabled = true  # Enable BBCode
	
	# Setup OnScreen Timer (3 seconds visible)
	on_screen_timer.wait_time = 3.0
	on_screen_timer.autostart = false
	on_screen_timer.one_shot = true
	on_screen_timer.timeout.connect(_on_on_screen_timer_timeout)
	add_child(on_screen_timer)
	
	# Setup OffScreen Timer (5 seconds hidden)
	off_screen_timer.wait_time = 5.0
	off_screen_timer.autostart = true
	off_screen_timer.one_shot = false
	off_screen_timer.timeout.connect(_on_off_screen_timer_timeout)
	add_child(off_screen_timer)
	
	# Attempt to find the Game node
	await get_tree().create_timer(1.0).timeout  # Small delay to allow scene loading
	if get_tree().get_current_scene().has_node("Game"):
		game = get_tree().get_current_scene().get_node("Game")
	
	if game:
		print("Game node found successfully!")
	else:
		print("Error: Game node NOT found!")

func _on_off_screen_timer_timeout():
	show_elements()
	on_screen_timer.start()

func _on_on_screen_timer_timeout():
	hide_elements()
	off_screen_timer.start()

func show_elements():
	rich_text.visible = true
	parrot.visible = true
	dialogbox.visible = true
	update_score()

func hide_elements():
	rich_text.visible = false
	parrot.visible = false
	dialogbox.visible = false

func update_score():
	if game and game.has_method("get_score"):
		var player_score = game.get_score()
		rich_text.text = "[font=res://fonts/Attack Of Monster.otf][color=#FFFF00][font_size=28]Player Score: " + str(player_score) + "[/font_size][/color][/font]"
	else:
		print("Game node or get_score method not available!")
