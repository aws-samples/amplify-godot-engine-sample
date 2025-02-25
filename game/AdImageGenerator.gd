class_name AdImageGenerator
extends Node

signal images_generated

var generated_images: Array[ImageTexture] = []

func generate_image(prompt: String, negative_prompt: String, color_palette: Array[Color], p_seed = 0, p_width = 576, p_height = 1024, p_cfgScale = 6.5, p_number_of_images = 1) -> Array[ImageTexture]:
	var hex_colors = color_palette.map(func(color: Color): return "#" + color.to_html(false))
	var query = """adsImageGenerator(prompt: "%s", negativePrompt: %s, color_palette: %s width: %d, height: %d, cfgScale: %f, seed: %d, numberOfImage: %d)""" % [
		_sanitize_string(prompt), 
		_sanitize_string(negative_prompt),
		"[" + ",".join(hex_colors) + "]",
		p_width, 
		p_height, 
		p_cfgScale, 
		p_seed % 2147483646, # Bedrock constraint seeds cannont exced 2147483646
		p_number_of_images
	]
	var response = await aws_amplify.data.query(query, "GetImage")
	var string_response = response.result.data.adsImageGenerator
	var json_response = JSON.parse_string(string_response)

	if json_response == null || not(json_response.has("statusCode")):
		print("error while parsing the response")
		
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
				print(JSON.stringify(json_response.body))
				images_generated.emit({ "images": null, "error": json_response.body })
				return []
	else:
		if json_response.body.has("body"):
			print(JSON.stringify(json_response.body))
			images_generated.emit({ "images": null, "error": json_response.body })
			return []
	
	images_generated.emit({ 
		"image": null,
		"error": json_response
	})
	return []

func _sanitize_string(input: String) -> String:
	var output = input
	# Remove or replace problematic characters
	output = output.replace("\"", "") # Remove double quotes
	output = output.replace("'", "") # Remove single quotes
	output = output.replace("\\", "") # Remove backslashes
	return output
