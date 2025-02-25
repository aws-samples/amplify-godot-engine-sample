class_name NovaCanvasPrompt
extends Resource

# Text-to-image parameters
@export var text: String = ""
@export var negative_text: String = ""

# Configuration parameters
@export var width: int = 1024  
@export var height: int = 1024
@export var quality: String = "standard"
@export_range(1.1, 10.0) var cfg_scale: float = 6.5
@export_range(1, 5) var number_of_images: int = 1
@export_range(0, 858993459) var seed: int = 12

# Color palette configuration
@export var colors: Array[String] = []

# Constructor with optional parameters
func _init(p_text: String = "", p_negative_text: String = ""):
	text = p_text
	negative_text = p_negative_text

# Convert the parameters to a dictionary for API request
func to_dict() -> Dictionary:
	var dict = {}
	
	# Set task type and parameters based on whether colors are specified
	if colors.is_empty():
		dict["taskType"] = "TEXT_IMAGE"
		dict["textToImageParams"] = {
			"text": text,
			"negativeText": negative_text
		}
	else:
		dict["taskType"] = "COLOR_GUIDED_GENERATION"
		dict["colorGuidedGenerationParams"] = {
			"colors": colors,
			"text": text,
			"negativeText": negative_text
		}
	
	# Add common image generation config
	dict["imageGenerationConfig"] = {
		"width": width, 
		"height": height,
		"quality": quality,
		"cfgScale": cfg_scale,
		"numberOfImages": number_of_images,
		"seed": seed
	}
		
	return dict
