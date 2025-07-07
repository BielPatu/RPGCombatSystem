extends Skill



func _init() -> void:
	skill_name = "Chicote traçado"
	skill_value = 12
	skill_chance = 95
	is_AOE = true
	is_skill_buff_active = false
	status_effects_DB = [preload("res://StatusEffect/Vulnerabilidade/vulnerability_I.gd")]	
	
func activate(user, target, value, battleSceneController, prompt):
	var text = "{name} usa {ability}".format({"name": user.char_name, "ability": skill_name})
	await prompt.animatedText(text)
	for targets in target:
		if precisionTest(skill_chance):
			if evasionTest(targets.char_evasion):
				learnStatus()
				for effects in status_effects:
					effects.activate(user, target, value, battleSceneController, prompt)
				var _newValue = criticalStrikeTest(user.char_critical_blow, value)
				targets.char_life -= floatingDamage(_newValue, user.char_damage, targets.char_defense)
		else:
			pass
