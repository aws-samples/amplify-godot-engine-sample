extends Control

@onready var rich_text: RichTextLabel = $RichTextLabel
@onready var parrot: TextureRect = $TextureRect
@onready var dialogbox: TextureRect = $DialogBox
@onready var game: Node = null
@onready var next_trigger_score: int = 0
@onready var first_cycle_done: bool = false
@onready var has_response: bool = false
@onready var active: bool = false
@onready var player: Player = null

func _ready():
	# Ensure everything is hidden initially
	hide_elements()
	
	# active feature
	activate()
	# reset variable
	first_cycle_done = false
	
	rich_text.bbcode_enabled = true  # Enable BBCode
	
	# Attempt to find the Game node
	await get_tree().create_timer(5.0).timeout  # Small delay to allow scene loading
	if get_tree().get_current_scene().has_node("Game"):
		game = get_tree().get_current_scene().get_node("Game")
	if game.has_node("Player"):
		player = game.get_node("Player")
		player.hit.connect(_on_player_hit)
		print("Player node found successfully!")
	
	if game:
		print("Game node found successfully!")
	else:
		print("Error: Game node NOT found!")
	
	# Ensure first cycle runs when score is zero
	await get_tree().create_timer(3.0).timeout
	await _cycle_logic()
	first_cycle_done = true

func activate():
	active = true
	
func deactivate():
	active = false

func _on_player_hit(_position: Vector3):
	deactivate()

func _process(_delta):
	_check_score()

func _check_score():
	if (!active):
		return
	
	# First check if game reference exists and is still valid
	if not is_instance_valid(game) or game == null:
		# Try to find the game node again
		if get_tree() and get_tree().get_current_scene() and get_tree().get_current_scene().has_node("Game"):
			game = get_tree().get_current_scene().get_node("Game")
		else:
			# print("Game node not found or scene tree is invalid")
			return
	
	# Add debug print to track game node state
	# print("Game node state: ", game, " valid: ", is_instance_valid(game))
	
	# Now check if the method exists
	if is_instance_valid(game) and game.has_method("get_score"):
		var player_score = game.get_score()
		# print("Current score: ", player_score, " Next trigger: ", next_trigger_score)
		if first_cycle_done and player_score >= next_trigger_score:
			print("Triggering cycle at score: " + str(player_score))
			next_trigger_score += 5
			call_deferred("_cycle_logic")  # Use call_deferred to avoid potential timing issues
	#else:
		#print("Game node or get_score method not available")

func _cycle_logic():
	if (!active):
		return
	
	if not is_instance_valid(game):
		# print("Game node invalid before refresh_leaderboard")
		return
		
	# Start the cycle by refreshing the leaderboard first
	await _refresh_leaderboard()
	
	if not is_instance_valid(game):
		# print("Game node invalid after refresh_leaderboard")
		return
		
	# Only show if there is a response
	if (has_response):
		show_elements()
		await get_tree().create_timer(5.0).timeout
		hide_elements()
		has_response = false # Reset for next response

func show_elements():
	rich_text.visible = true
	parrot.visible = true
	dialogbox.visible = true

func hide_elements():
	rich_text.visible = false
	parrot.visible = false
	dialogbox.visible = false

func update_score(commentary = ""):
	rich_text.text = "[font=res://fonts/Attack Of Monster.otf][color=#FFFF00][font_size=28]" + commentary + "[/font_size][/color][/font]"

func _refresh_leaderboard():
	if (!active):
		return
		
	if game == null:
		print("Game node not found, cannot refresh leaderboard.")
		return
	
	var request = """listScoreByLeaderboardAndScore(leaderboard: "%s", sortDirection: DESC, limit:%s) { items { score username } }""" % ["global", "30"]
	var response = await aws_amplify.data.query(request, "ListLeaderboard")

	print(response.result)
	if response.result and response.result.has("data"):
		var items = response.result.data.listScoreByLeaderboardAndScore.items
		var leaderboard_string = "0 Score"

		if items.size() > 0:
			leaderboard_string = ""
			for i in items.size():
				var item = items[i]
				leaderboard_string += "%s %s %s\\n" % [str(i + 1), item.username, item.score]
 		
		# Append player's latest score at the end
		if game and game.has_method("get_score"):
			var player_score = game.get_score()
			leaderboard_string += "\\nPlayers Score: %s" % str(player_score)
		
		print(leaderboard_string)
		
		await _generate_ai_commentary(leaderboard_string)
	else:
		print("Error retrieving leaderboard: " + str(response.error))

func _generate_ai_commentary(leaderboard_string: String):

	var query = """
	GenAiCommentary(prompt: "Leadership Board (in order) from first to last: %s")
	""" % leaderboard_string
	
	print(query)
	
	var response = await aws_amplify.data.query(query, "GenAiCommentary")

	if response.result and response.result.has("data"):
		var json_response = JSON.parse_string(response.result.data["GenAiCommentary"])
		
		if json_response and json_response.has("statusCode") and json_response.statusCode == 200:
			var commentary = json_response.body.commentary
			print(commentary)
			
			has_response = true # Share that there is a response available
			update_score(commentary)  # Only update UI when commentary is ready
		else:
			print("Error: Unexpected AI response format: " + JSON.stringify(json_response))
	else:
		print("Error retrieving AI commentary: " + str(response.error))
