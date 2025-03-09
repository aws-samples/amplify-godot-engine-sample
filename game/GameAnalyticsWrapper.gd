extends Node


func record(userid, event, score, xpos, ypos, sessionid, adclicked,genre):
	
	var body = JSON.stringify({
		"Version": 1,
		"Game_Build": 1.0,
		"User_Id": userid,
		"Session_Id": sessionid,
		"Time": str(int(Time.get_unix_time_from_system())),
		"Event": {
			"Event_Type": event,
			"Score": score,
			"X_Position": xpos,
			"Y_Position": ypos,
			"Ad_Clicked": adclicked,
			"Genre_Selected": genre
			}
		
	})
	aws_amplify.custom_analytics.record(body)

func query():
	var response = await aws_amplify.custom_analytics.query()
	print(response)
	var jsonresponse = JSON.parse_string(response)
	var clicks: Array[float] =  [float(jsonresponse["data"]["personalizedClicks"]),float(jsonresponse["data"]["neutralClicks"])]
	return(clicks)
