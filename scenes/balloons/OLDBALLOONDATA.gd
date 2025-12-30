#extends Node
#
#var balloon_data = {
	#"red_balloon": {
		#"health": 1,
		#"speed": 0.01,
		#"sprite_path": "res://assets/sprites/balloons/red_balloon.png",
		#"contains": [],
		#"resistances": []
	#},
	#"blue_balloon": {
		#"health": 1,
		#"speed": 0.015,
		#"sprite_path": "res://assets/sprites/balloons/blue_balloon.png",
		#"contains": ["red_balloon"],
		#"resistances": []
	#},
	#"green_balloon": {
		#"health": 1,
		#"speed": 0.02,
		#"sprite_path": "res://assets/sprites/balloons/green_balloon.png",
		#"contains": ["blue_balloon"],
		#"resistances": []
	#},
	#"yellow_balloon": {
		#"health": 1,
		#"speed": 0.025,
		#"sprite_path": "res://assets/sprites/balloons/yellow_balloon.png",
		#"contains": ["green_balloon"],
		#"resistances": []
	#},
	#"pink_balloon": {
		#"health": 1,
		#"speed": 0.03,
		#"sprite_path": "res://assets/sprites/balloons/pink_balloon.png",
		#"contains": ["yellow_balloon"],
		#"resistances": []
	#},
	#"black_balloon": {
		#"health": 1,
		#"speed": 0.03,
		#"sprite_path": "res://assets/sprites/balloons/black_balloon.png",
		#"contains": ["pink_balloon", "pink_balloon"],
		#"resistances": ["explosion"]
	#},
	#"white_balloon": {
		#"health": 1,
		#"speed": 0.03,
		#"sprite_path": "res://assets/sprites/balloons/white_balloon.png",
		#"contains": ["pink_balloon", "pink_balloon"],
		#"resistances": ["freeze"]
	#},
	#"zebra_balloon": {
		#"health": 1,
		#"speed": 0.03,
		#"sprite_path": "res://assets/sprites/balloons/zebra_balloon.png",
		#"contains": ["black_balloon", "white_balloon"],
		#"resistances": ["explosion", "freeze"]
	#},
	#"lead_balloon":{
		#"health": 1,
		#"speed": 0.01,
		#"sprite_path": "res://assets/sprites/balloons/lead_balloon.png",
		#"contains": ["black_balloon", "black_balloon"],
		#"resistances": ["normal"]
	#},
	#"rainbow_balloon": {
		#"health": 1,
		#"speed": 0.05,
		#"sprite_path": "res://assets/sprites/balloons/rainbow_balloon.png",
		#"contains": ["zebra_balloon", "zebra_balloon"],
		#"resistances": []
	#},
	#"ceramic_balloon": {
		#"health": 10,
		#"speed": 0.02,
		#"sprite_path": "res://assets/sprites/balloons/ceramic_balloon.png",
		#"contains": ["rainbow_balloon", "rainbow_balloon"],
		#"resistances": []
	#}
#}
#
##func _ready():
	### At start of game, calculate damage that player should take
	### 	for each type of balloon reaching the exit
	##for balloon_type in balloon_data:
		##balloon_data[balloon_type]["damage"] = calculate_balloon_total_score(balloon_type)
##
##func calculate_balloon_total_score(balloon_type: String) -> int:
	##var total_score = BalloonData.balloon_data[balloon_type]["health"]
	##var contains_list = BalloonData.balloon_data[balloon_type]["contains"]
	##
	##if len(contains_list) == 0:
		##return BalloonData.balloon_data[balloon_type]["health"]
	##else:
		##for contained_balloon in contains_list:
			##total_score += calculate_balloon_total_score(contained_balloon)
	##return total_score
