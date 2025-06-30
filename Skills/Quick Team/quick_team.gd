extends Skill

class_name QuickTeam

func _init() -> void:
	skill_name = "Quick Team"
	skill_value = 30
	skill_chance = 95
	
	
func activate(user, target, value):
	user.char_evasion += value	
