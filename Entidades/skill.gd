extends Node

class_name Skill

var skill_name: String
var skill_value: int
var skill_buff: int
var skill_debuff: int
var skill_chance: int


func _init(_name: String, value: int, buff: int, debuff: int, evasionRate: int) -> void:
	_name = skill_name
	value = skill_value
	buff = skill_buff
	debuff = skill_debuff
	evasionRate = skill_chance


func activate(_user: Char, _target: Char, _value: int) -> void:
	pass
