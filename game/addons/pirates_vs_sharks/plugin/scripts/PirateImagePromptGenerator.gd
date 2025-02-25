@tool
class_name PirateImagePromptGenerator
extends EditorScript

const SAVE_DIR := "res://prompts/commercials/"

# Focus types constant
const FOCUS_TYPES = [
	PiratePrompt.FocusType.CHARACTER,
	PiratePrompt.FocusType.WORLD,
	PiratePrompt.FocusType.STYLIZED
]

# Configuration for concise prompts
const SYSTEM_PROMPT := """Create high-impact promotional game art combining naval battles and shark encounters."""

# Genre-specific subject elements
const GENRE_SUBJECTS = {
	GameGenre.Id.ARPG: "epic naval combat with power-enhanced pirates",
	GameGenre.Id.BATTLE_ROYALE: "last-ship-standing battle with encroaching shark-infested waters",
	GameGenre.Id.CARD_GAME: "strategic deployment of ship and crew cards against shark threats",
	GameGenre.Id.CITY_BUILDER: "fortified harbor city defending against maritime threats",
	GameGenre.Id.FIGHTING: "close-quarters combat between pirates and anthropomorphic sharks",
	GameGenre.Id.FPS: "intense ship-to-shark combat with naval artillery",
	GameGenre.Id.HORROR: "terrifying encounters with monstrous deep-sea predators",
	GameGenre.Id.LIFE_SIM: "daily life aboard a pirate ship amid shark-filled waters",
	GameGenre.Id.MOBA: "team-based ship combat with shark-controlled territories",
	GameGenre.Id.OPEN_WORLD: "vast oceanic exploration with dynamic shark encounters",
	GameGenre.Id.PARTY_GAME: "chaotic multiplayer pirate challenges amid shark chaos",
	GameGenre.Id.PLATFORM: "acrobatic deck-hopping through shark-infested waters",
	GameGenre.Id.PUZZLE: "tactical positioning of ships to outsmart shark patterns",
	GameGenre.Id.RACING: "high-speed ship racing through shark obstacle courses",
	GameGenre.Id.RHYTHM: "musical ship maneuvers avoiding synchronized shark attacks",
	GameGenre.Id.RPG: "character-driven epic with deep shark-fighting mechanics",
	GameGenre.Id.SPORTS: "competitive naval sports with shark hazards",
	GameGenre.Id.STRATEGY: "tactical fleet management against shark armadas",
	GameGenre.Id.SURVIVAL: "resource management and survival against marine predators",
	GameGenre.Id.VISUAL_NOVEL: "narrative-driven encounters with mysterious shark entities"
}

# Focus-specific subject templates
const FOCUS_TEMPLATES = {
	PiratePrompt.FocusType.CHARACTER: "Hero engaged in {genre_action}, showcasing detailed character expressions and dramatic poses",
	PiratePrompt.FocusType.WORLD: "Vast seascape featuring {genre_action}, emphasizing environmental scale and atmosphere",
	PiratePrompt.FocusType.STYLIZED: "Artistic interpretation of {genre_action} with bold compositions and dramatic elements"
}

# Base prompt template for concise output
const BASE_PROMPT := """Generate '{genre_name}' game genre key art for 'Pirates vs Sharks':
Subject: {subject}
Setting: {region_name} {region_description}
Style: {art_style} with {style_elements}
Elements: {genre_elements}
Composition: Dynamic camera, volumetric lighting, atmospheric effects
Colors:
- Sails and flags: {pirate_primary}
- Pirate clothes: {pirate_secondary} with {pirate_tertiary} details
Technical: High resolution {style_visuals}"""

func _run():
	print("Generating commercial prompts for all game genres and styles...")
	generate_commercial_prompts_for_style(
		GameStyle.REALISTIC_3D,
		PirateRegion.CARIBBEAN,
		PirateColor.CLASSIC
	)

func generate_commercial_prompts_for_style(style: GameStyle, region: PirateRegion, color: PirateColor):
	print("\nGenerating prompts for style: " + style.display_name)
	print("Region: " + region.name)
	print("Color Scheme: " + color.name)
	
	# Ensure the save directory exists
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)
	
	for genre in GameGenre.ALL_GENRES:
		var genre_folder = GameGenre.Id.keys()[genre.id].to_pascal_case().to_lower()
		print("\nGenerating prompts for %s (folder: %s):" % [genre.display_name, genre_folder])
		
		# Create a subdirectory for each genre
		var genre_dir = SAVE_DIR + genre_folder + "/"
		if not DirAccess.dir_exists_absolute(genre_dir):
			DirAccess.make_dir_absolute(genre_dir)
		
		for focus in FOCUS_TYPES:
			var prompt = PiratePrompt.Commercial(
				style,
				genre,
				region,
				color,
				720,    # Default width
				1280,   # Default height
				focus
			)
			
			# Create the regional color palette
			var region_palette: Array[Color] = [
				region.primary_color,
				region.secondary_color,
				region.tertiary_color
			]
			
			# Create the pirate color palette
			var pirate_palette: Array[Color] = [
				color.primary_color,
				color.secondary_color,
				color.tertiary_color
			]
			
			# Combine both palettes
			prompt.colors = _convert_colors_to_hex(region_palette + pirate_palette)
			
			# Combine genre and focus for subject
			var genre_action = GENRE_SUBJECTS[genre.id]
			var subject = FOCUS_TEMPLATES[focus].format({"genre_action": genre_action})
			
			# Override the default prompt with our concise version
			prompt.text = SYSTEM_PROMPT + "\n\n" + BASE_PROMPT.format({
				"genre_name": genre.display_name,
				"subject": subject,
				"art_style": style.display_name,
				"region_name": region.name,
				"region_description": region.description,
				"style_elements": style.visual_elements[0],
				"genre_elements": genre.interactions[0],
				"style_visuals": ", ".join(style.visual_effects),
				"pirate_primary": color.primary_color.to_html(),
				"pirate_secondary": color.secondary_color.to_html(),
				"pirate_tertiary": color.tertiary_color.to_html(),
			})
			
			# Add focus-specific details
			match focus:
				PiratePrompt.FocusType.CHARACTER:
					prompt.text += "\nFocus: Close-up action, emotional intensity, dramatic poses"
				PiratePrompt.FocusType.WORLD:
					prompt.text += "\nFocus: Epic scale, vast seascape, rich atmosphere"
				PiratePrompt.FocusType.STYLIZED:
					prompt.text += "\nFocus: Bold composition, enhanced drama, exaggerated scale"
			
			var filename = "%s_%s.tres" % [
				PiratePrompt.FocusType.keys()[focus].to_lower(),
				style.display_name.to_snake_case()
			]
			
			var err = ResourceSaver.save(prompt, genre_dir + filename)
			if err == OK:
				print("Saved prompt: " + genre_dir + filename)
			else:
				push_error("Failed to save prompt: " + filename)
	
	print("\nPrompt generation completed for style: " + style.display_name)
	print("Prompts saved in: " + SAVE_DIR)

# Helper function to convert colors to hex strings
static func _convert_colors_to_hex(colors: Array[Color]) -> Array[String]:
	var hex_colors: Array[String] = []
	for color in colors:
		hex_colors.append("#" + color.to_html())
	return hex_colors
