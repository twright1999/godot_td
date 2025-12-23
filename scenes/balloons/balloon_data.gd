extends Node

var balloon_data = {
	"red_balloon": {
		"health": 1,
		"speed": 0.01,
		"sprite_path": "res://assets/sprites/balloons/red_balloon.png",
		"contains": [],
		"resistances": []
	},
	"blue_balloon": {
		"health": 1,
		"speed": 0.015,
		"sprite_path": "res://assets/sprites/balloons/blue_balloon.png",
		"contains": ["red_balloon", "red_balloon", "red_balloon", "red_balloon", "red_balloon"],
		"resistances": []
	},
	"green_balloon": {
		"health": 1,
		"speed": 0.02,
		"sprite_path": "res://assets/sprites/balloons/green_balloon.png",
		"contains": ["blue_balloon"],
		"resistances": []
	},
	"yellow_balloon": {
		"health": 1,
		"speed": 0.025,
		"sprite_path": "placeholder",
		"contains": ["green_balloon"],
		"resistances": []
	},
	"pink_balloon": {
		"health": 1,
		"speed": 0.03,
		"sprite_path": "placeholder",
		"contains": ["yellow_balloon"],
		"resistances": []
	},
	"black_balloon": {
		"health": 1,
		"speed": 0.03,
		"sprite_path": "placeholder",
		"contains": ["pink_balloon", "pink_balloon"],
		"resistances": ["explosion"]
	},
	"white_balloon": {
		"health": 1,
		"speed": 0.03,
		"sprite_path": "placeholder",
		"contains": ["pink_balloon", "pink_balloon"],
		"resistances": ["freeze"]
	},
	"zebra_balloon": {
		"health": 1,
		"speed": 0.03,
		"sprite_path": "placeholder",
		"contains": ["black_balloon", "white_balloon"],
		"resistances": ["explosion", "freeze"]
	},
	"rainbow_balloon": {
		"health": 1,
		"speed": 0.05,
		"sprite_path": "placeholder",
		"contains": ["zebra_balloon", "zebra_balloon"],
		"resistances": []
	},
	"ceramic_balloon": {
		"health": 10,
		"speed": 0.02,
		"sprite_path": "placeholder",
		"contains": ["zebra_balloon", "zebra_balloon"],
		"resistances": []
	}
}
