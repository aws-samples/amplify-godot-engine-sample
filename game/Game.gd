extends Node

var NEUTRAL_TAGLINES = [
	"Beyond The Horizon",
	"Legends of the Deep",
	"Masters of the Sea",
	"Tides of Destiny",
	"Ocean's Challenge",
	"Dark Waters Rising",
	"Waters Unknown",
	"Deep Blue Legacy",
	"Sea of Dreams",
	"Waves of Fortune"
]

var NEUTRAL_CALL_TO_ACTIONS = [
	"Play Now",
	"Begin Adventure",
	"Join Today",
	"Start Journey",
	"Play Free",
	"Download Now",
	"Join Battle",
	"Start Playing",
	"Join Others",
	"Begin Now"
]

var GAME_OVER_MESSAGES = [
	"Davy Jones' Locker Claims Another...",
	"The Sharks Had Their Final Say",
	"Your Tale Ends in the Deep",
	"Sleeping With the Fishes",
	"The Sea Shows No Mercy",
	"A Feast for the Sharks",
	"Your Ship's Final Voyage",
	"The Ocean Claims Its Prize",
	"Not Even a Splash Left",
	"A Sailor's Final Journey",
	"The Perfect Shark Snack",
	"Should've Brought a Bigger Boat...",
	"The Deep Blue Wins Again",
	"Lost to the Endless Sea",
	"A Pirate's Last Adventure",
	"Today's Special: Pirate Soup",
	"The Sharks Send Their Regards",
	"Even Captain Hook Lasted Longer",
	"That's Why We Need Lifeboats",
	"The Sea Was Hungry Today"
]

const COMERCIAL_TIMEOUT = 10

@export var mob_scene: PackedScene

@onready var score: Control = %Score
@onready var info: Messaging = %Info
@onready var countdown: Countdown = %Countdown
@onready var game_over: Messaging = %GameOver
@onready var player: Player = $Player

@onready var commercial_container: Control = %CommercialContainer
@onready var commercial_a: AdButton = %CommercialA
@onready var commercial_b: AdButton = %CommercialB
@onready var commercial_c: AdButton = %CommercialC
@onready var commercial_video_commentary: TypingRichTextLabel = %CommercialVideoCommentary
@onready var commercial_video_player: VideoStreamPlayer = %CommercialVideoPlayer
@onready var commercial_video_voice_over_player: AudioStreamPlayer = %CommercialVideoVoiceOverPlayer
@onready var commercial_video_container: Control = %CommercialVideoContainer
@onready var commercial_video_button: Button = %CommercialVideoButton
@onready var commercial_statistics_container: Control = %CommercialStatisticsContainer
@onready var commercial_statistics_pie_chart: PieChart = %CommercialStatisticsPieChart
@onready var commercial_statistics_button: BlinkingButton = %CommercialStatisticsButton
@onready var leaderboard_container: Control = %LeaderboardContainer
@onready var leaderboard: ItemList = %Leaderboard
@onready var leaderboard_retry: Button = %LeaderboardRetry
@onready var leaderboard_quit: Button = %LeaderboardQuit
@onready var genre = game_genres.selected_genre
@onready var commentary: Control = $UserInterface/Commentary

var sessionID
var theme_index


func _ready():
	
	theme_index = randi_range(0, 1)
	
	music_player.play(music_player.Themes.LOOP, theme_index)
	
	$UserInterface/Retry.hide()
	sessionID = str(int(Time.get_unix_time_from_system()))
	player.player_name.text = GlobalData.player_name
	genre = game_genres.selected_genre
	
	# Images
	var commercials = [commercial_a, commercial_b, commercial_c]
	GameAnalytics.record(GlobalData.player_name, "GAME_START", 0, 0, 0, sessionID, "","")
	GameAnalytics.record(GlobalData.player_name, "SELECTED_GENRE",0,0,0,sessionID,"",genre.name)
	var personalized_commercial_index = randi() % commercials.size()
	var personalized_commercial = commercials[personalized_commercial_index]
	
	personalized_commercial.title.text = game_genres.selected_genre.tagline
	personalized_commercial.button.text = game_genres.selected_genre.call_to_action
	personalized_commercial.is_personalized = true
	
	ad_image_generator.images_generated.connect(_on_image_generated.bind(personalized_commercial))
	
	if ad_image_generator.generated_images && not ad_image_generator.generated_images.is_empty():
		personalized_commercial.image.texture = ad_image_generator.generated_images[0]
	else:
		personalized_commercial.image.texture = load(genre.images[randi() % genre.images.size()])
		# info.display("Practice Time!", 1)

	commercials.remove_at(personalized_commercial_index)
	
	var neutral_commercial_indices = [1, 2, 3]
	for neutral_commercial in commercials:
		var neutral_commercial_index = randi() % neutral_commercial_indices.size()
		neutral_commercial.title.text = NEUTRAL_TAGLINES[randi() % NEUTRAL_TAGLINES.size()]
		neutral_commercial.image.texture = load("res://art/images/neutral_%d.png" % neutral_commercial_indices[neutral_commercial_index])
		neutral_commercial.button.text = NEUTRAL_CALL_TO_ACTIONS[randi() % NEUTRAL_CALL_TO_ACTIONS.size()]
		neutral_commercial_indices.remove_at(neutral_commercial_index)

	# Connect the commercial buttons
	commercial_a.pressed.connect(_on_commercial_pressed.bind(commercial_a))
	commercial_b.pressed.connect(_on_commercial_pressed.bind(commercial_b))
	commercial_c.pressed.connect(_on_commercial_pressed.bind(commercial_c))
	commercial_a.mouse_entered.connect(_on_commercial_mouse_entered.bind(commercial_a))
	commercial_b.mouse_entered.connect(_on_commercial_mouse_entered.bind(commercial_b))
	commercial_c.mouse_entered.connect(_on_commercial_mouse_entered.bind(commercial_c))

	# Video
	commercial_video_player.stream = VideoStreamTheora.new()
	commercial_video_player.stream.file = game_genres.selected_genre.videos[1]
	
	# Voice Over
	var voice_over_path = game_genres.selected_genre.voices[randi_range(0,1)]
	print(voice_over_path)
	commercial_video_voice_over_player.stream = load(voice_over_path)
	
func _on_image_generated(result, commercial: AdButton):
	if result.images:
		commercial.image.texture = result.images[0]
	else:
		print(result.error)
		
	_countdown()
	
func _countdown():
	info.visible = false
	countdown.visible = true
	countdown.start()

func _on_countdown_timeout() -> void:
	player.practicing = false

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

func _on_player_hit(_position: Vector3):
	$MobTimer.stop()
	$UserInterface/Retry.show()

	score.visible = false
	
	game_over.display(GAME_OVER_MESSAGES[randi() % GAME_OVER_MESSAGES.size()], 1)
	
	music_player.play(music_player.Themes.COMMERCIAL, theme_index)
	
	await _update_player_score()
	await _refresh_leaderboard()
	
func _on_game_over_timout() -> void:
	game_over.visible = false
	commercial_container.visible = true
	var commercials = [commercial_a, commercial_b, commercial_c]
	commercial_a.grab_focus()
	commercials[randi() % commercials.size()].grab_focus()

func _on_mob_squashed(position: Vector3):
	GameAnalytics.record(GlobalData.player_name, "SCORE", score.score,snappedf(position.x,0.1),snappedf((-1 * position.z),0.1), sessionID, "","")

func _update_player_score():
	var current_score = int(score.score)
	var get_score_response = await aws_amplify.data.query("""getScore(leaderboard: "%s", username: "%s") { score }""" % ["global", GlobalData.player_name], "GetScore")

	if get_score_response.result:
		if get_score_response.result.data.getScore == null:
			await aws_amplify.data.mutation("""createScore(input: {leaderboard: "%s", score: %s, username: "%s"}) { createdAt }""" % ["global", str(current_score), GlobalData.player_name], "CreateScore")
		elif int(get_score_response.result.data.getScore.score) < current_score:
			await aws_amplify.data.mutation("""updateScore(input: {leaderboard: "%s", score: %s, username: "%s"}) { createdAt }""" % ["global", str(current_score), GlobalData.player_name], "UpdateScore")
	else:
		print("Error: " + get_score_response.to_string())
		
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
		print(response.error)

func _on_disconnect_button_pressed() -> void:
	var response = await aws_amplify.auth.sign_out(true)
	if response.error:
		print(response.error.message)

func _on_leaderboard_retry_pressed():
	# reload the tree and starts at the beginning of the game
	get_tree().reload_current_scene()

func _on_leaderboard_quit_pressed() -> void:
	ad_image_generator.generated_images = []
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

# func _on_commercial_a_pressed() -> void:
# 	var ad_type = "personalized" if commercial_a.is_personalized else "neutral"
# 	print(ad_type)
# 	GameAnalytics.record(GlobalData.player_name,"AD_CLICK",0,0,0,sessionID,ad_type,genre.name)
# 	_on_commercial_pressed()

# func _on_commercial_b_pressed() -> void:
# 	var ad_type = "personalized" if commercial_b.is_personalized else "neutral"
# 	print(ad_type)
# 	GameAnalytics.record(GlobalData.player_name,"AD_CLICK",0,0,0,sessionID,ad_type,genre.name)
# 	_on_commercial_pressed()

# func _on_commercial_c_pressed() -> void:
# 	var ad_type = "personalized" if commercial_c.is_personalized else "neutral"
# 	print(ad_type)
# 	GameAnalytics.record(GlobalData.player_name,"AD_CLICK",0,0,0,sessionID,ad_type,genre.name)
# 	_on_commercial_pressed() 

func _on_commercial_mouse_entered(commercial: AdButton) -> void:
	commercial.grab_focus()

func _on_commercial_pressed(commercial: AdButton) -> void:
	var ad_type = "personalized" if commercial.is_personalized else "neutral"
	#print(ad_type)
	GameAnalytics.record(GlobalData.player_name, "AD_CLICK", 0, 0, 0, sessionID, ad_type, genre.name)
	
	commercial_container.visible = false
	info.text = "Analyzing..."
	info.show()
	var clicks = await GameAnalytics.query()
	info.text = ""
	info.hide()
	commercial_statistics_container.visible = true
	commercial_statistics_pie_chart.values = clicks
	commercial_statistics_pie_chart.start_animation()

func _on_commercial_statistics_pie_chart_animation_finished() -> void:
	commercial_statistics_button.visible = true
	commercial_statistics_button.grab_focus()

func _on_commercial_statistics_button_pressed() -> void:
	commercial_statistics_container.visible = false
	commercial_video_container.visible = true
	commercial_video_commentary.type_text(game_genres.selected_genre.voice_over, true)
	music_player.audio_stream_player.volume_db = -15
	commercial_video_player.play()
	commercial_video_voice_over_player.play()

func _on_commercial_video_voice_over_player_finished() -> void:
	music_player.audio_stream_player.volume_db = 0
	commercial_video_commentary.text = ""
	commercial_video_button.visible = true
	commercial_video_button.grab_focus()
	
func _on_commercial_video_button_pressed() -> void:
	commercial_video_container.visible = false
	leaderboard_container.visible = true
	leaderboard_retry.grab_focus()

func get_score() -> int:
	return score.score
	
