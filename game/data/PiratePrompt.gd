@tool
extends Resource
class_name PiratePrompt

const DEFAULT_WIDTH := 1024
const DEFAULT_HEIGHT := 1024
const DEFAULT_QUALITY := "standard"
const DEFAULT_CFG_SCALE := 6.5
const DEFAULT_NUM_IMAGES := 1
const DEFAULT_SEED := 12
const DEFAULT_COLORS: Array[Color] = []

func generate_all_image_prompts(
		genre: GameGenre, 
		style: GameStyle, 
		width: int = DEFAULT_WIDTH,
		height: int = DEFAULT_HEIGHT,
		quality: String = DEFAULT_QUALITY,
		cfg_scale: float = DEFAULT_CFG_SCALE,
		number_of_images: int = DEFAULT_NUM_IMAGES,
		seed: int = DEFAULT_SEED,
		colors: Array[Color] = DEFAULT_COLORS
	) -> Array[NovaCanvasPrompt]:
	
	var prompts: Array[NovaCanvasPrompt] = []
	
	for i in range(genre.image_subjects.size()):
		var image_seed = seed + i
		prompts.append(generate_for_subject(
			genre, style, i,
			width, height, quality,
			cfg_scale, number_of_images,
			image_seed, colors
		))
	
	return prompts

func generate_for_subject(
		genre: GameGenre, 
		style: GameStyle, 
		subject_index: int,
		width: int,
		height: int,
		quality: String,
		cfg_scale: float,
		number_of_images: int,
		seed: int,
		colors: Array[Color]
	) -> NovaCanvasPrompt:
	
	var subject = genre.image_subjects[subject_index]
	var prompt = NovaCanvasPrompt.new(
		_build_caption_prompt(subject, style),
		_build_negative_prompt(style)
	)
	
	prompt.width = width
	prompt.height = height
	prompt.quality = quality
	prompt.cfg_scale = cfg_scale
	prompt.number_of_images = number_of_images
	prompt.seed = seed
	
	# Convert Color objects to hex strings
	var hex_colors: Array[String] = []
	for color in colors:
		hex_colors.append("#" + color.to_html(false))
	prompt.colors = hex_colors
	
	return prompt

func _build_caption_prompt(subject: String, style: GameStyle) -> String:
	var system_context = _build_system_prompt(style)
	return "{system_context}. {subject}, {artistic_style}".format({
		"system_context": system_context,
		"subject": subject,
		"artistic_style": style.artistic_style
	})

func _build_system_prompt(style: GameStyle) -> String:
	return """Create promotional key art in {style_name} style with {technical}""".format({
		"style_name": style.name,
		"technical": style.technical_specs
	})

func _build_negative_prompt(style: GameStyle) -> String:
	var base_terms = ["low quality", "blurry", "watermark", "logo", "distorted"]
	
	match style.id:
		GameStyle.Id.PIXEL_ART:
			base_terms += ["realistic", "smooth", "photorealistic", "high detail"]
		GameStyle.Id.REALISTIC_3D:
			base_terms += ["cartoon", "cel-shaded", "stylized", "hand-drawn"]
		GameStyle.Id.ANIME:
			base_terms += ["photorealistic", "western cartoon", "realistic shading"]
		GameStyle.Id.MINIMALIST:
			base_terms += ["detailed", "complex", "noisy", "cluttered"]
		GameStyle.Id.HAND_DRAWN_2D:
			base_terms += ["3d", "photorealistic", "computer generated"]
		_:
			base_terms += ["poor quality", "amateur"]
	
	return ", ".join(base_terms)
