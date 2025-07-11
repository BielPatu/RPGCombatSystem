extends Node

class_name Status

var status_name: String
var status_value: int
var status_turn_duration: int
var is_status_activated: bool
var which_turn_ends: int
var old_status := {
	"char_max_life": 0,
	"char_damage": 0,
	"char_defense": 0,
	"char_evasion": 0,
	"char_critical_blow": 0,
	"char_level": 0 
}
var old_skill := { 
	"skill_name": "",
	"skill_value": 0,
	"skill_buff": 0,
	"skill_debuff": 0,
	"skill_chance": 0
}
var user: Char
var target: Array


func _init(name: String, value: int, duration: int) -> void:
	status_name = name
	status_value = value
	status_turn_duration = duration


func activate(user, target, value, battleSceneController, prompt) -> void:
	pass
	
func deactivate():
	for t in target:
		t.char_max_life = old_status["char_max_life"]
		t.char_damage = old_status["char_damage"]
		t.char_defense = old_status["char_defense"]
		t.char_evasion = old_status["char_evasion"]
		t.char_critical_blow = old_status["char_critical_blow"]
		t.char_level = old_status["char_level"]

		for s in t.skill_set:
			s.skill_name = old_skill["skill_name"]
			s.skill_value = old_skill["skill_value"]
			s.skill_buff = old_skill["skill_buff"]
			s.skill_debuff = old_skill["skill_debuff"]
			s.skill_chance = old_skill["skill_chance"]
	
func verifyTurn(battleSceneController)-> bool:
	if battleSceneController.turn == which_turn_ends:
		deactivate()
		return true
			
	return false
	
func update_status_dictionary() -> void:
	if target.size() == 0:
		return
	var t = target[0]
	old_status["char_max_life"] = t.char_max_life
	old_status["char_damage"] = t.char_damage
	old_status["char_defense"] = t.char_defense
	old_status["char_evasion"] = t.char_evasion
	old_status["char_critical_blow"] = t.char_critical_blow
	old_status["char_level"] = t.char_level	
	
func update_skill_dictionary() -> void:
	if target.size() == 0:
		return
	var t = target[0]
	if t.skill_set.size() == 0:
		return
	var s = t.skill_set[0]
	old_skill["skill_name"] = s.skill_name
	old_skill["skill_value"] = s.skill_value
	old_skill["skill_buff"] = s.skill_buff
	old_skill["skill_debuff"] = s.skill_debuff
	old_skill["skill_chance"] = s.skill_chance
		
