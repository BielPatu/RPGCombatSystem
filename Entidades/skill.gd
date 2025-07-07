extends Node

class_name Skill

var skill_name: String
var skill_value: int
var skill_buff: int
var skill_debuff: int
var skill_chance: int
var is_skill_buff_active: bool
var buff_round_start_status: bool
var skill_custom_prompt: bool
var status_effects: Array = []
var status_effects_DB: Array = []
var is_AOE: bool

func _init(_name: String, value: int, buff: int, debuff: int, evasionRate: int) -> void:
	skill_name = _name
	skill_value = value
	skill_buff = buff
	skill_debuff = debuff
	skill_chance = evasionRate
	buff_round_start_status = false
	is_skill_buff_active = false

func activate(_user: Char, _target: Array, _value: int, battleSceneController: Node2D, prompt: Label) -> void:
	if not is_AOE:
		var currentTarget = _target[0]
		if precisionTest(skill_chance):
			if evasionTest(currentTarget.char_evasion):
				var _newValue = criticalStrikeTest(_user.char_critical_blow, _value)
				currentTarget.char_life -= floatingDamage(_newValue, _user.char_damage, currentTarget.char_defense)
				var text = "{name} usa {ability}".format({"name": _user.char_name, "ability": skill_name})
				await prompt.animatedText(text)
			else:
				var text = "{name} usa {ability} mas {target} esquiva!".format({
					"name": _user.char_name,
					"ability": skill_name,
					"target": currentTarget.char_name
				})
				await prompt.animatedText(text)
		else:
			var text = "{name} usa {ability} mas falha".format({"name": _user.char_name, "ability": skill_name})
			await prompt.animatedText(text)
	else:
		# Texto geral só uma vez
		var text = "{name} usa {ability}".format({"name": _user.char_name, "ability": skill_name})
		await prompt.animatedText(text)
		
		# Depois aplica dano em cada alvo, sem texto
		for target in _target:
			if precisionTest(skill_chance):
				if evasionTest(target.char_evasion):
					var _newValue = criticalStrikeTest(_user.char_critical_blow, _value)
					target.char_life -= floatingDamage(_newValue, _user.char_damage, target.char_defense)
				# Se quiser, pode fazer algo aqui para alvos que esquivaram, mas sem spammar texto
			else:
				# Falha no AOE, aqui não repete texto para cada alvo
				pass


func floatingDamage(skill_value: int, char_damage: int, defense: int) -> int:
	var base_damage = (skill_value / 2.0) * char_damage
	var floatingdamage = base_damage + randf_range(base_damage * -0.13, base_damage * 0.13)
	var reduction = clamp(defense / 75.0 * 0.99, 0.0, 0.99)
	var final_damage = floatingdamage * (1.0 - reduction)
	return int(final_damage)


func precisionTest(userPrecision: int) -> bool:
	return randf_range(0, 100) <= userPrecision


func evasionTest(targetEvasion: int) -> bool:
	return randf_range(0, 100) > targetEvasion


func criticalStrikeTest(userCriticalChance: int, userDamage: int) -> int:
	if randf_range(0, 100) < userCriticalChance:
		return userDamage * 3
	else:
		return userDamage


func SkillBuffCheck() -> bool:
	return is_skill_buff_active


func learnStatus():
	for effect_script in status_effects_DB:
		var status_instance = effect_script.new()
		status_effects.append(status_instance)
