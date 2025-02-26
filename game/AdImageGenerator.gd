class_name AdImageGenerator
extends Node

signal image_generated

var generated_image

func generate_image(p_genre, p_seed = 0, p_width = 576, p_height = 1024, p_cfgScale = 6.5) -> void:
	var query = """adsImageGenerator(prompt: "%s", negativePrompt: "%s", width: %d, height: %d, cfgScale: %f, seed: %d)""" % [
		_sanitize_string(p_genre.prompt), 
		_sanitize_string(p_genre.negative_prompt),
		p_width, p_height, p_cfgScale, p_seed % 2147483646 # Bedrock constraint seeds cannont exced 2147483646
	]
	var response = await aws_amplify.data.query(query, "GetImage")
	var string_response = response.result.data.adsImageGenerator
	var json_response = JSON.parse_string(string_response)

	if json_response == null || not(json_response.has("statusCode")):
		print("error while parsing the response")
		
	if json_response.statusCode == 200:
		if json_response.has("body"):
			if json_response.body.has("images") && json_response.body.images.size() > 0:
				var img = Image.new()
				img.load_png_from_buffer(Marshalls.base64_to_raw(json_response.body.images[0]))
				generated_image = ImageTexture.create_from_image(img)	
				image_generated.emit(generated_image)
			else:
				print(JSON.stringify(json_response.body))
	else:
		if json_response.body.has("body"):
			print(JSON.stringify(json_response.body))

func _sanitize_string(input: String) -> String:
	var output = input
	# Remove or replace problematic characters
	output = output.replace("\"", "") # Remove double quotes
	output = output.replace("'", "") # Remove single quotes
	output = output.replace("\\", "") # Remove backslashes
	return output
