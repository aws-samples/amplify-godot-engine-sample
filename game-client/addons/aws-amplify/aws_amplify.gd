extends Node

var auth_token = ''
var client_id = ''
var cognito_endpoint = ''

func _ready():
	
	var file_path = "res://amplify_outputs.json"
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file:
		var content = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(content)
		
		if parse_result == OK:
			var result = json.get_data()
			var auth = result["auth"]
			var region = auth["aws_region"]
			cognito_endpoint = "https://cognito-idp." + region + ".amazonaws.com/"
			client_id = auth["user_pool_client_id"]
			
			print("File loaded, Cognito Endpoint: ", cognito_endpoint)
			print("Client ID: ", client_id)
			
			
		else:
			print("Failed to parse JSON")
	else:
		print("File does not exist: ", file_path)
	

func authenticate(email, password):
	var response = await _send_authentication_request(email, password)
	var result = response[0]
	var response_code = response[1]
	var body = response[3]
	
	if result == HTTPRequest.RESULT_SUCCESS:
		var json = JSON.parse_string(body.get_string_from_utf8())
		if json.has("AuthenticationResult") and json.AuthenticationResult.has("AccessToken"):
			auth_token = json.AuthenticationResult.AccessToken
			return true
		else:
			return false
	else:
		return false
		
#func _process_rest_response(response):
	#var result = response[0]
	#var response_code = response[1]
	#var body = response[3]
	#
	#if result == HTTPRequest.RESULT_SUCCESS:
		#var json = JSON.parse_string(body.get_string_from_utf8())
#
		##if json.has("AuthenticationResult") and json.AuthenticationResult.has("AccessToken"):
			##auth_token = json.AuthenticationResult.AccessToken
			##return {"success": true, "json": json}
		##else:
			##return {"success": false, "error": "Invalid response format"}
	#else:
		#return {"success": false, "error": "Request failed", "code": result}
	
	
func _send_authentication_request(email, password):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	# Cognito configuration
	#var cognito_endpoint = "https://cognito-idp.eu-west-3.amazonaws.com/"
	#var client_id = "7d14jtf5abdj5p419eac4qm97k"
	
	# Prepare headers
	var headers = [
		"X-Amz-Target: AWSCognitoIdentityProviderService.InitiateAuth",
		"Content-Type: application/x-amz-json-1.1"
	]
	
	# Prepare request body
	var body = JSON.stringify({
		"AuthFlow": "USER_PASSWORD_AUTH",
		"ClientId": client_id,
		"AuthParameters": {
			"USERNAME": email,
			"PASSWORD": password
		}
	})
	
	var error = http_request.request(cognito_endpoint, headers, HTTPClient.METHOD_POST, body)
	if error != OK:
		return {"error": "Failed to send request"}

	# Wait for the request to complete
	var response = await http_request.request_completed
	
	# Clean up the HTTPRequest node
	http_request.queue_free()
	
	return response

#func authenticate(email, password):
	#
	## Create an HTTPRequest node
	#var http_request = HTTPRequest.new()
	#add_child(http_request)
	#
	## Connect the request_completed signal
	#http_request.request_completed.connect(self._on_authenticate_request_completed)
	#
	## Cognito configuration
	#var cognito_endpoint = "https://cognito-idp.eu-west-3.amazonaws.com/"
	#var client_id = "7d14jtf5abdj5p419eac4qm97k"
	#
	## Prepare headers
	#var headers = [
		#"X-Amz-Target: AWSCognitoIdentityProviderService.InitiateAuth",
		#"Content-Type: application/x-amz-json-1.1"
	#]
	#
	## Prepare request body
	#var body = JSON.stringify({
		#"AuthFlow": "USER_PASSWORD_AUTH",
		#"ClientId": client_id,
		#"AuthParameters": {
			#"USERNAME": email,
			#"PASSWORD": password
		#}
	#})
#
	## Send the request
	#http_request.request(cognito_endpoint, headers, HTTPClient.METHOD_POST, body)
	#
#func _on_authenticate_request_completed(result, response_code, headers, body):
	#if result == HTTPRequest.RESULT_SUCCESS:
		#var json = JSON.parse_string(body.get_string_from_utf8())
		#auth_token = json.AuthenticationResult.AccessToken
		##print("Response: ", json.AuthenticationResult.AccessToken)
	#else:
		#print("Error: ", result)
