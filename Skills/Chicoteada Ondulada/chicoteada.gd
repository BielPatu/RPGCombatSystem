extends Skill

func _init() -> void:
	skill_name = "Chicote traçado"
	skill_value = 12
	skill_chance = 95
	is_AOE = true
	is_skill_buff_active = false
	status_effects_DB = [preload("res://StatusEffect/Vulnerability/vulnerability_I.gd")]
	status_effects = []

func activate(user, target, value, battleSceneController, prompt):
	var text = "{name} usa {ability}".format({"name": user.char_name, "ability": skill_name})
	await prompt.animatedText(text)

	for t in target:
		if precisionTest(skill_chance) and evasionTest(t.char_evasion):
			for effect_scene in status_effects_DB:
				var temp_instance = effect_scene.new()

				if battleSceneController.isStatusAlreadyActive(temp_instance.status_name, t):
					print("Status", temp_instance.status_name, "já está ativo em", t.char_name)
					continue

				temp_instance.activate(user, [t], value, battleSceneController, prompt)
				status_effects.append(temp_instance)

			var _newValue = criticalStrikeTest(user.char_critical_blow, value)
			t.char_life -= floatingDamage(_newValue, user.char_damage, t.char_defense)
