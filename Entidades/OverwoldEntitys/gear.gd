extends Resource

class_name Gear

var gear_name: String 
var gear_value: Dictionary = {}
var description: String 

func _init(_name: String = "", _value: Dictionary = {}, _description: String = ""):
	gear_name = _name
	gear_value = _value
	description = _description

func activate(character) -> void:
	print("ativando gear")
	for stat in gear_value:
		if stat in character:
			character.set(stat, character.get(stat) + gear_value[stat])
		else:
			print("Status não encontrado: ", stat)
