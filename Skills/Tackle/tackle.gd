extends Skill

class_name Tackle


func _init() -> void:
	skill_name = "Tackle"
	skill_value = 10
	skill_chance = 95
	
	
func activate(user, target, value) -> void:
	target.char_life -= value
	

	
