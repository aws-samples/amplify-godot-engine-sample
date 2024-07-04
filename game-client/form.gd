extends Control

@onready var mail_input = $MailInput
@onready var password_input = $PasswordInput
@onready var signin_button = $SignInButton
@onready var test_button = $TestButton

# Called when the node enters the scene tree for the first time.
func _ready():
	signin_button.pressed.connect(_on_button_pressed)
	test_button.pressed.connect(_on_test_button_pressed)
	
	pass # Replace with function body.

func _on_test_button_pressed():
	
	print(AwsAmplify.auth_token)

func _on_button_pressed():
	
	print(mail_input.text + " " + password_input.text)
	
	var success = await AwsAmplify.authenticate(mail_input.text, password_input.text)
	if success:
		get_tree().change_scene_to_file("res://Main.tscn")
	
	# Create an HTTPRequest node
	#var http_request = HTTPRequest.new()
	#add_child(http_request)
	#
	## Connect the request_completed signal
	#http_request.request_completed.connect(self._on_request_completed)
	## Cognito configuration
	#var cognito_endpoint = "https://cognito-idp.eu-west-3.amazonaws.com/"
	#var client_id = "7d14jtf5abdj5p419eac4qm97k"
	#var username = "iouerghi+a4gsandbox@amazon.fr"
	#var password = "Iouerghi+a4gsandbox"
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
			#"USERNAME": username,
			#"PASSWORD": password
		#}
	#})
	#
	## Send the request
	#http_request.request(cognito_endpoint, headers, HTTPClient.METHOD_POST, body)
	
	
	#var http_request = HTTPRequest.new()
	#add_child(http_request)
	## Connect the request_completed signal
	#http_request.request_completed.connect(self._on_request_completed)
	## Send a GET request to a sample API
	#http_request.request("https://jsonplaceholder.typicode.com/todos/1")
	
func _on_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		var json = JSON.parse_string(body.get_string_from_utf8())
		print("Response: ", json)
	else:
		print("Error: ", result)

