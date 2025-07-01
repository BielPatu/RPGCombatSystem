extends Node

class_name Skill

var skill_name: String
var skill_value: int
var skill_buff: int
var skill_debuff: int
var skill_chance: int
var is_skill_buff_active: bool
var buff_round_start_status: bool


func _init(_name: String, value: int, buff: int, debuff: int, evasionRate: int) -> void:
	_name = skill_name
	value = skill_value
	buff = skill_buff
	debuff = skill_debuff
	evasionRate = skill_chance
	buff_round_start_status = false
	is_skill_buff_active = buff_round_start_status
	


func activate(_user: Char, _target: Char, _value: int) -> void:
	if precisionTest(self.skill_chance) == true:
		if evasionTest(_target.char_evasion) == true:
			var _newValue =	criticalStrikeTest(_user.char_critical_blow, _value)
			_target.char_life -= floatingDamage(_newValue)
	
	
func floatingDamage(value: int) -> int:
	var floatingdamage = (value + randf_range(value * 0.13, value * (-0.13)))
	return floatingdamage
	
func precisionTest(userPrecision: int) -> bool:
	if randf_range(0, 100) <= userPrecision:
		return true
	else:
		return false		
	
func evasionTest(targetEvasion: int) -> bool:
		if randf_range(0, 100) > targetEvasion:
			return true
		else:
			return false
			
func criticalStrikeTest(userCriticalChance: int, userDamage: int) -> int:
		if randf_range(0, 100) < userCriticalChance:
			return userDamage*3
		else:
			return userDamage
			
func SkillBuffCheck() -> bool:
	if self.is_skill_buff_active == true:
		return true
	else: 
		return false			
