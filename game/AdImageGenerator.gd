class_name AdImageGenerator
extends Node

signal images_generated

var generated_images: Array[ImageTexture] = []
var generation_errors = null

func generate_image(p_prompt: String, p_negative_prompt: String = "", p_colors: Array[Color] = [], p_width = 576, p_height = 1024, p_cfgScale = 6.5, p_seed = 0, p_number_of_images = 1) -> Array[ImageTexture]:
	var hex_colors
	
	if p_colors:
		hex_colors = p_colors.map(func(color: Color): return "#" + color.to_html(false))
	else:
		hex_colors = []
		
	var query = """adsImageGenerator(prompt: "%s", negativePrompt: "%s", colors: "%s", width: %d, height: %d, cfgScale: %f, seed: %d, numberOfImages: %d)""" % [
		_sanitize_string(p_prompt), 
		_sanitize_string(p_negative_prompt),
		','.join(hex_colors),
		p_width, 
		p_height, 
		p_cfgScale, 
		p_seed % 2147483646, # Bedrock constraint seeds cannot exced 2147483646
		p_number_of_images
	]
	var response = await aws_amplify.data.query(query, "GetImage")
		
	if response.error:
		return _error(response.error)
		
	if not response.result || not response.result.data:
		return _error(response.result)
		
	var string_response = response.result.data.adsImageGenerator
	var json_response = JSON.parse_string(string_response)
	if json_response == null || not(json_response.has("statusCode")):
		return _error(response.result)
		
	if json_response.statusCode == 200:
		if json_response.has("body"):
			if json_response.body.has("images") && json_response.body.images.size() > 0:
				generated_images = []
				for image in json_response.body.images:
					var img = Image.new()
					img.load_png_from_buffer(Marshalls.base64_to_raw(image))
					generated_images.append(ImageTexture.create_from_image(img)	)
				images_generated.emit({ "images": generated_images, "error": null })
				return generated_images
			else:
				return _error(json_response.body)
	else:
		if json_response.body.has("body"):
			return _error(json_response.body)
	
	return _error(json_response)

func _error(error) -> Array[ImageTexture]:
	generation_errors = error
	images_generated.emit({ "images": null, "error": error })	
	print("error: %s" % error)
	return []

func _sanitize_string(input: String) -> String:
	var output = input
	# Remove or replace problematic characters
	output = output.replace("\"", "") # Remove double quotes
	output = output.replace("'", "") # Remove single quotes
	output = output.replace("\\", "") # Remove backslashes
	return output
