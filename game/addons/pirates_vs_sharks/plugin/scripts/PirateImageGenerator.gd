@tool
class_name PirateCommercialImageGenerator
extends EditorScript

const PROMPTS_DIR := "res://prompts/"
const SAVE_DIR := "res://assets/commercials/"
const IMAGES_PER_PROMPT := 3

var ad_image_generator = AdImageGenerator.new()

func _run():
	print("Generating commercial images for all prompts...")
	
	# Ensure the save directory exists
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)
	
	# Start processing from the root prompts directory
	await process_directory(PROMPTS_DIR, SAVE_DIR)
	
	print("\nCommercial image generation completed!")
	print("Images saved in: " + SAVE_DIR)

func process_directory(current_path: String, output_path: String):
	print("\nProcessing directory: " + current_path)
	
	# Ensure output directory exists
	if not DirAccess.dir_exists_absolute(output_path):
		DirAccess.make_dir_absolute(output_path)
	
	var dir = DirAccess.open(current_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.begins_with("."):
				file_name = dir.get_next()
				continue
				
			var full_path = current_path.path_join(file_name)
			var output_sub_path = output_path.path_join(file_name)
			
			if dir.current_is_dir():
				# Recursively process subdirectories
				await process_directory(full_path, output_sub_path)
			elif file_name.ends_with(".tres"):
				# Process prompt file
				await generate_images_for_prompt(full_path, output_path)
				
			file_name = dir.get_next()
			
		dir.list_dir_end()

func generate_images_for_prompt(prompt_path: String, output_dir: String) -> Dictionary:
	# Load the prompt resource
	var prompt = load(prompt_path) as NovaCanvasPrompt
	if not prompt:
		push_error("Failed to load prompt from: " + prompt_path)
		return {}
	
	# Get the base filename without extension
	var file_name = prompt_path.get_file().get_basename()
	print("Generating images for prompt: " + file_name)
	
	# Convert color palette to Array[Color]
	var color_palette: Array[Color] = []
	for color_str in prompt.colors:
		color_palette.append(Color(color_str))
	
	print(ad_image_generator)
	
	# Wait for and process the images_generated signal
	var result = await ad_image_generator.generate_image(
		prompt.text,
		prompt.negative_text,
		color_palette,
		randi(),  # Random seed
		prompt.width,
		prompt.height,
		prompt.cfg_scale,
		IMAGES_PER_PROMPT  # Number of images to generate
	)
	
	if not result.is_empty():
		# Save all generated images
		for i in range(result.images.size()):
			var filename = "%s_v%d.png" % [file_name, i + 1]
			var filepath = output_dir.path_join(filename)
			
			result.images[i].get_image().save_png(filepath)
			print("Saved image: " + filepath)
	else:
		push_error("Failed to generate images for %s: %s" % [file_name, result.error])
	
	return result
