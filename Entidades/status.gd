extends Node

class_name Status

var status_name: String
var status_value: int
var status_turn_duration: int



func _init(name: String, value: int, duration: int) -> void:
	status_name = name
	status_value = value
	status_turn_duration = duration


func activate(user, target, value, battleSceneController, prompt) -> void:
	pass
	
func deactivate(user, target, value, battleSceneController, prompt) -> void:
	pass	
