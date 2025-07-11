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
	learnStatus()

	if not is_AOE:
		var currentTarget = _target[0]
		if precisionTest(skill_chance):
			if evasionTest(currentTarget.char_evasion):
				applyStatusEffects(_user, currentTarget, _value, battleSceneController, prompt)
				var _newValue = criticalStrikeTest(_user.char_critical_blow, _value)
				currentTarget.char_life -= floatingDamage(_newValue, _user.char_damage, currentTarget.char_defense)
				var text = "{name} usa {ability}".format({"name": _user.char_name, "ability": skill_name})
				await prompt.animatedText(text)
			else:
				await prompt.animatedText("{name} usa {ability} mas {target} esquiva!".format({
					"name": _user.char_name,
					"ability": skill_name,
					"target": currentTarget.char_name
				}))
		else:
			await prompt.animatedText("{name} usa {ability} mas falha".format({
				"name": _user.char_name,
				"ability": skill_name
			}))
	else:
		await prompt.animatedText("{name} usa {ability}".format({
			"name": _user.char_name,
			"ability": skill_name
		}))

		for t in _target:
			if precisionTest(skill_chance) and evasionTest(t.char_evasion):
				applyStatusEffects(_user, t, _value, battleSceneController, prompt)
				var _newValue = criticalStrikeTest(_user.char_critical_blow, _value)
				t.char_life -= floatingDamage(_newValue, _user.char_damage, t.char_defense)

func applyStatusEffects(_user, _target, _value, battleSceneController, prompt):
	for effect in status_effects:
		if battleSceneController.isStatusAlreadyActive(effect.status_name, _target):
			continue
		var instance = effect.duplicate()
		instance.activate(_user, [_target], _value, battleSceneController, prompt)

func floatingDamage(skill_value: int, char_damage: int, defense: int) -> int:
	var base_damage = (skill_value / 2.0) * char_damage
	var floatingdamage = base_damage + randf_range(base_damage * -0.13, base_damage * 0.13)
	var reduction = clamp(defense / 75.0 * 0.75, 0.0, 0.75)
	var final_damage = floatingdamage * (1.0 - reduction)
	return int(final_damage)

func precisionTest(userPrecision: int) -> bool:
	return randf_range(0, 100) <= userPrecision

func evasionTest(targetEvasion: int) -> bool:
	return randf_range(0, 100) > targetEvasion

func criticalStrikeTest(userCriticalChance: int, userDamage: int) -> int:
	return userDamage * 3 if randf_range(0, 100) < userCriticalChance else userDamage

func SkillBuffCheck() -> bool:
	return is_skill_buff_active

func learnStatus():
	status_effects.clear()
	for effect_script in status_effects_DB:
		status_effects.append(effect_script.new())
