extends Node

const COMERCIAL_TIMEOUT = 10

@export var mob_scene: PackedScene

@onready var score: Control = %Score
@onready var player: Player = $Player

@onready var commercial_container: Control = %CommercialContainer
@onready var commercial_a: AdButton = %CommercialA
@onready var commercial_b: AdButton = %CommercialB
@onready var commercial_c: AdButton = %CommercialC
@onready var commercial_video_container: Control = %CommercialVideoContainer
@onready var commercial_video_player: VideoStreamPlayer = %CommercialVideoPlayer
@onready var commercial_video_button: Button = %CommercialVideoButton
@onready var commercial_progress_bar: ProgressBar = %CommercialProgressBar
@onready var commercial_timeout: float = COMERCIAL_TIMEOUT
@onready var leaderboard_container: Control = %LeaderboardContainer
@onready var leaderboard: ItemList = %Leaderboard
@onready var leaderboard_retry: Button = %LeaderboardRetry
@onready var leaderboard_quit: Button = %LeaderboardQuit
@onready var commentary: Control = $UserInterface/Commentary
@onready var ai_chat: Control = $UserInterface/AiChat

var sessionID

func _ready():
	music_player.play(music_player.Themes.LOOP, 0)
	
	$UserInterface/Retry.hide()
	
	sessionID = str(int(Time.get_unix_time_from_system()))
	player.player_name.text = GlobalData.player_name
	
	aws_amplify.custom_analytics.record(GlobalData.player_name, "GAME_START", 0, 0, 0, sessionID, "")
	
	var genre = game_genres.selected_genre
	var commercials = [commercial_a, commercial_b, commercial_c]
	
	var personalized_commercial_index = randi() % commercials.size()
	var personalized_commercial = commercials[personalized_commercial_index]
	personalized_commercial.label.text = "Pirates vs Sharks"

	ad_image_generator.image_generated.connect(_on_image_generated.bind(personalized_commercial))
	
	if ad_image_generator.generated_image:
		personalized_commercial.image.texture = ad_image_generator.generated_image
	else:
		personalized_commercial.image.texture = load(genre.ads[randi() % genre.ads.size()])

	commercials.remove_at(personalized_commercial_index)
	
	var neutral_commercial_indices = [1, 2, 3, 4, 5]
	for neutral_commercial in commercials:
		var neutral_commercial_index = randi() % neutral_commercial_indices.size()
		neutral_commercial.label.text = "Pirates vs Sharks"
		neutral_commercial.image.texture = load("res://art/ads/neutral_%d.png" % neutral_commercial_indices[neutral_commercial_index])
		neutral_commercial_indices.remove_at(neutral_commercial_index)

func _on_image_generated(image, commercial: AdButton):
	commercial.image.texture = image

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Communicate the spawn location and the player's location to the mob.
	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
	# We connect the mob to the score label to update the score upon squashing a mob.
	mob.squashed.connect($UserInterface/Score._on_mob_squashed)
	mob.squashed.connect(_on_mob_squashed)

func _on_player_hit(position: Vector3):
	score.visible = false
	
	music_player.play(music_player.Themes.COMMERCIAL, 0)
	
	commercial_container.visible = true
	
	var commercials = [commercial_a, commercial_b, commercial_c]
	commercials[randi() % commercials.size()].grab_focus()
		
	$MobTimer.stop()
	$UserInterface/Retry.show()
	
	aws_amplify.custom_analytics.record(GlobalData.player_name, "GAME_END", score.score, position.x,(-1 * position.z), sessionID, "")
	
	await _update_player_score()
	await _refresh_leaderboard()

func _on_mob_squashed(position: Vector3):
	aws_amplify.custom_analytics.record(GlobalData.player_name, "SCORE", score.score, position.x,(-1 * position.z), sessionID, "")

func _update_player_score():
	var current_score = int(score.score)
	var get_score_response = await aws_amplify.data.query("""getScore(leaderboard: "%s", username: "%s") { score }""" % ["global", GlobalData.player_name], "GetScore")

	if get_score_response.result:
		if get_score_response.result.data.getScore == null:
			await aws_amplify.data.mutation("""createScore(input: {leaderboard: "%s", score: %s, username: "%s"}) { createdAt }""" % ["global", str(current_score), GlobalData.player_name], "CreateScore")
		elif int(get_score_response.result.data.getScore.score) < current_score:
			await aws_amplify.data.mutation("""updateScore(input: {leaderboard: "%s", score: %s, username: "%s"}) { createdAt }""" % ["global", str(current_score), GlobalData.player_name], "UpdateScore")
	else:
		print("Error: " + get_score_response.error.message)
		
func _refresh_leaderboard():
	var request = """listScoreByLeaderboardAndScore(leaderboard: "%s", sortDirection: DESC, limit:%s) { items { score username } }""" % ["global", "30"]
	var response = await aws_amplify.data.query(request, "ListLeaderboard")

	if response.result and response.result.has("data"):
		var items = response.result.data.listScoreByLeaderboardAndScore.items
		leaderboard.clear()
		for i in items.size():
			var item = items[i]
			leaderboard.add_item("%s | %s %s" % [str(i + 1), item.username, item.score])
	else:
		print(response.error.message)

func _on_disconnect_button_pressed() -> void:
	var response = await aws_amplify.auth.sign_out(true)
	if response.error:
		print(response.error.message)

func _on_leaderboard_retry_pressed() -> void:
	get_parent().change_scene("res://Game.tscn")

func _on_leaderboard_quit_pressed() -> void:
	ad_image_generator.generated_image = null
	get_parent().change_scene("res://Title.tscn")

func _on_user_attributes_update_button_pressed() -> void:
	$MobTimer.start()
	$UserInterface/PlayerAttributes.visible = false

func _on_user_attributes_button_pressed(toggled) -> void:
	if toggled:
		$MobTimer.stop()
		$UserInterface/PlayerAttributes.visible = true
	else:
		$MobTimer.start()
		$UserInterface/PlayerAttributes.visible = false

func _on_commercial_a_pressed() -> void:
	aws_amplify.custom_analytics.record(GlobalData.player_name,"AD_CLICK",0,0,0,"","A")
	_on_commercial_pressed()

func _on_commercial_b_pressed() -> void:
	aws_amplify.custom_analytics.record(GlobalData.player_name,"AD_CLICK",0,0,0,"","B")
	_on_commercial_pressed()

func _on_commercial_c_pressed() -> void:
	aws_amplify.custom_analytics.record(GlobalData.player_name,"AD_CLICK",0,0,0,"","C")
	_on_commercial_pressed() 

func _on_commercial_pressed() -> void:
	commercial_a.visible = false
	commercial_b.visible = false
	commercial_c.visible = false
	commercial_video_container.visible = true
	commercial_video_player.play()

func _on_commercial_video_finished() -> void:
	commercial_video_player.play()
	commercial_video_button.visible = true
	commercial_video_button.grab_focus()

func _on_commercial_video_button_pressed() -> void:
	commercial_container.visible = false
	leaderboard_container.visible = true
	leaderboard_retry.grab_focus()
	
func get_score() -> int:
	return score.score if score else 0
	
