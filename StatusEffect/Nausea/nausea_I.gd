extends Status

class_name Nausea

func _init() -> void:
	status_name = 'Nausea I'
	status_value = 70
	status_turn_duration = 5

func activate(user, target, value, battleSceneController, prompt):
	for x in target.skill_set:
		x.skill_chance = max(10, x.skill_chance - (x.skill_chance * self.status_value / 100.0))
	target.char_evasion = 1	
	
	
func deactivate(user, target, value, battleSceneController, prompt):
	for x in target.skill_set:
		x.skill_chance = max(10,x.skill_chance - self.status_value)
	target.char_evasion = 1	
	var text = "Nausea Ativada"
	await prompt.animatedText(text)	
	
