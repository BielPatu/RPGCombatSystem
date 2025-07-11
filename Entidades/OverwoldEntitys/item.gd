extends Node

class_name Item

var item_name: String
var item_value: int
var item_quantity: int
var item_type: String


func _init(_name: String, value: int, quantity: int, type: String) -> void:
	item_name = _name
	item_quantity = quantity
	item_type = type
	item_value = value
	
	
func activate(_user: Char, target: Array, value: int, battle_controller: Node2D, prompt: Label):
	await prompt.animatedText("{user} usou {name}".format({"user": _user.char_name, "name": self.item_name}))
	_user.char_life += value	
	
