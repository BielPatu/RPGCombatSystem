extends Skill

class_name QuickTeam

func _init() -> void:
	skill_name = "Quick Team"
	skill_value = 30
	skill_chance = 95
	status_effects_DB = [preload("res://StatusEffect/Nimble/evasion_I.gd")]
	
func activate(user, target, value, battleSceneController, prompt):
	learnStatus()
	status_effects[0].activate(user, target, value, battleSceneController, prompt)
	var text = ("{name} usa {ability}".format({"name": user.char_name, "ability": self.skill_name}))
	await prompt.animatedText(text)
	await battleSceneController.get_tree().create_timer(1).timeout
		
