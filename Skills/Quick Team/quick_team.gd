extends Skill

class_name QuickTeam

func _init() -> void:
	skill_name = "Quick Team"
	skill_value = 30
	skill_chance = 95
	
	
func activate(user, target, value, battleSceneController, prompt):
	if SkillBuffCheck() == false:
		if precisionTest(skill_chance) == true:
			user.char_evasion += value
			is_skill_buff_active = true	
			await prompt.animatedText("{name} usou {skill}".format({"name": user.char_name, "skill": self.skill_name}))
			await battleSceneController.get_tree().create_timer(1).timeout
			await prompt.animatedText("A evasão de {name} aumentou drasticamente".format({"name": user.char_name, "skill": self.skill_name}))
			
	else:
		pass	
