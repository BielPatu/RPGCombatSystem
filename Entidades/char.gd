extends Node

class_name Char

var char_character_image: Texture2D

var char_name: String
var char_label_name: Label
var char_life_slider: ProgressBar

var char_max_life: int
var char_life: int

var char_damage: int
var char_level: int

var char_defense: int
var char_evasion: int

var learnable_skill_moves: Array
var skill_set: Array

func _init(Life: int, MaxLife: int, DMG: int, defense: int,
		   level: int, image: Texture2D, skillMove: Array, skillSet: Array,
		   labelName: Label, progressBar: ProgressBar, evasion: int) -> void:
	char_life = Life
	char_max_life = MaxLife
	char_damage = DMG
	char_defense = defense
	char_level = level
	char_character_image = image
	learnable_skill_moves = skillMove
	skill_set = skillSet
	char_label_name = labelName
	char_life_slider = progressBar
	char_evasion = evasion

func take_damage(damage: int, target: Char):
	pass

func add_skill(skill):
	skill_set.append(skill)
	
func SetHealthSlider() -> int:
	return (self.char_life * 100 / (self.char_max_life))
