extends Skill

class_name QuickTeam

func _init() -> void:
	skill_name = "Quick Team"
	skill_value = 30
	skill_chance = 95
	
	
func activate(user, target, value):
	if SkillBuffCheck() == false:
		if precisionTest(skill_chance) == true:
			user.char_evasion += value
			is_skill_buff_active = true	
	else:
		pass	
