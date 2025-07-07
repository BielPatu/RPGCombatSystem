extends Skill

class_name Enduring


func _init() -> void:
	skill_name = "Enduring"
	skill_value = 30
	skill_chance = 95
	is_skill_buff_active = false
	skill_buff = is_skill_buff_active
	status_effects = []

func activate(user, target, value, battleSceneController, prompt):
	if !SkillBuffCheck():
		user.char_defense += value
		is_skill_buff_active = true
		learnStatus() 

		var text = ("{name} usa {ability}".format({"name": user.char_name, "ability": self.skill_name}))
		await prompt.animatedText(text)
		await battleSceneController.get_tree().create_timer(1.5).timeout
	else:
		var text = ("{name} usa {ability} mas não funciona novamente".format({"name": user.char_name, "ability": self.skill_name}))
		await prompt.animatedText(text)
