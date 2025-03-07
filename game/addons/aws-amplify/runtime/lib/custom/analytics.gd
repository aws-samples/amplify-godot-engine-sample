## A class for handling AWS Amplify analytics operations.
##
class_name AWSAmplifyCustomAnalytics
extends Node

# TODO: Need to make that function generic and just send a JSON event
# TODO: It could also be interesting to define a genereric event enveloppe with all common parameters such as time, userid, sessionid and more 
# func record(event):
# 
func record(body):
	await _client.send(_analytics_endpoint, _headers, HTTPClient.METHOD_PUT, body)

func query():
	var response = await _client.send(_query_endpoint,_headers, HTTPClient.METHOD_GET, "")
	return response.result
	
## Initializes the AWSAmplifyAnalytics instance.
##
## @param client The AWSAmplifyClient instance.
## @param auth The AWSAmplifyAuth instance.
## @param config The configuration dictionary.
func _init(client: AWSAmplifyClient, auth: AWSAmplifyAuth, config: Dictionary) -> void:
	_client = client
	_auth = auth
	_config = config
	_endpoint = config["endpoint"]
	_analytics_endpoint = _endpoint + "data/"
	_query_endpoint = _endpoint + "query/"
	_key = config["apiKeyValue"]
	_headers = [ 
		"Content-Type: application/json",
		"x-api-key: " + _key
	]
	
## The AWS Amplify client instance.
var _client: AWSAmplifyClient

## The AWS Amplify authentication instance.
var _auth: AWSAmplifyAuth

## Configuration dictionary for the AWSAmplifyAnalytics instance.
var _config: Dictionary

## The API endpoint URL.
var _endpoint: String

var _analytics_endpoint: String

var _query_endpoint: String

## The API key URL.
var _key: String

## The API headers URL.
var _headers: Array
