extends Control

@onready var rich_text: RichTextLabel = $RichTextLabel
@onready var parrot: TextureRect = $TextureRect
@onready var dialogbox: TextureRect = $DialogBox
@onready var game: Node = null
@onready var next_trigger_score: int = 0
@onready var first_cycle_done: bool = false
@onready var has_response: bool = false

func _ready():
	# Ensure everything is hidden initially
	hide_elements()
	
	rich_text.bbcode_enabled = true  # Enable BBCode
	
	# Attempt to find the Game node
	await get_tree().create_timer(1.0).timeout  # Small delay to allow scene loading
	if get_tree().get_current_scene().has_node("Game"):
		game = get_tree().get_current_scene().get_node("Game")
	
	if game:
		print("Game node found successfully!")
	else:
		print("Error: Game node NOT found!")
	
	# Ensure first cycle runs when score is zero
	await _cycle_logic()
	first_cycle_done = true

func _process(delta):
	_check_score()

func _check_score():
	if  game and game.has_method("get_score"):
		var player_score = game.get_score()
		if first_cycle_done and player_score >= next_trigger_score:
			print("Triggering cycle at score: " + str(player_score))
			next_trigger_score += 5  # Increment trigger score for the next cycle
			await _cycle_logic()

func _cycle_logic():
	# Start the cycle by refreshing the leaderboard first
	await _refresh_leaderboard()
	
	# Only show if there is a response
	if (has_response):
		# Show elements for 5 seconds before hiding them
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
			leaderboard_string += "\\nYour Score: %s" % str(player_score)
		
		print(leaderboard_string)
		
		await _generate_ai_commentary(leaderboard_string)
	else:
		print("Error retrieving leaderboard: " + str(response.error))

func _generate_ai_commentary(leaderboard_string: String):
	
	
	var query = """
	GenAiCommentary(prompt: "%s")
	""" % leaderboard_string
	
	var response = await aws_amplify.data.query(query, "GenAiCommentary")

	if response.result and response.result.has("data"):
		var json_response = JSON.parse_string(response.result.data["GenAiCommentary"])
		
		if json_response and json_response.has("statusCode") and json_response.statusCode == 200:
			var commentary = json_response.body.commentary
			
			has_response = true # Share that there is a response available
			update_score(commentary)  # Only update UI when commentary is ready
		else:
			print("Error: Unexpected AI response format.")
	else:
		print("Error retrieving AI commentary: " + str(response.error))
