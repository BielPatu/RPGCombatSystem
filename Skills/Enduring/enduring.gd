extends Skill

class_name Enduring


func _init() -> void:
	skill_name = "Enduring"
	skill_value = 30
	skill_chance = 95
	is_skill_buff_active = false
	skill_buff = is_skill_buff_active
	status_effects_DB = [preload("res://StatusEffect/Nausea/nausea_I.gd")]
	status_effects = []

func activate(user, target, value, battleSceneController, prompt):
	learnStatus() 
	status_effects[0].activate(user, target, value, battleSceneController, prompt)
	var text = ("{name} usa {ability}".format({"name": user.char_name, "ability": self.skill_name}))
	await prompt.animatedText(text)
	await battleSceneController.get_tree().create_timer(1).timeout
