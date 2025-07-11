extends Node

class_name Char

var char_character_image: Texture2D

var char_name: String
var char_label_name: Label
var char_life_slider: ProgressBar

var char_max_life: int
var char_life: int

var char_critical_blow: int
var char_damage: int
var char_level: int
var char_type: String

var char_defense: int
var char_evasion: int

var learnable_skill_moves: Array
var skill_set: Array
var is_char_crumpled: bool
var is_char_poisoned: bool
var is_char_vinasAffected: bool
var char_status_effects: Array

var equipped_gears: Array = []
var type_of_stats := {
	"char_life": 0,
	"char_max_life": 0,
	"char_damage": 0,
	"char_defense": 0,
	"char_evasion": 0,
	"char_critical_blow": 0,
	"char_level": 0 }

func _init(Life: int, MaxLife: int, DMG: int, defense: int,
		   level: int, image: Texture2D, skillMove: Array, skillSet: Array,
		   labelName: Label, progressBar: ProgressBar, evasion: int,
		   criticalHit: int) -> void:
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
	char_critical_blow = criticalHit


##Dá update no dicionario de status	
func update_stat_dictionary() -> void:
	print("UpdatedDictonary")
	type_of_stats["char_life"] = char_life
	type_of_stats["char_max_life"] = char_max_life
	type_of_stats["char_damage"] = char_damage
	type_of_stats["char_defense"] = char_defense
	type_of_stats["char_evasion"] = char_evasion
	type_of_stats["char_critical_blow"] = char_critical_blow
	type_of_stats["char_level"] = char_level	

#Equipa a Gear individualmente	
func equip_gear(gear):
	if equipped_gears.size() < 3:
		equipped_gears.append(gear)
		gear.activate(self)
	else:
		print("Todos os slots de gear estão ocupados!")	

#Calcula os bonus de todas as gears e equipa tudo de uma vez
func calculate_total_stats():
	print("Calculando os status totais")
	update_stat_dictionary()
	for gear in equipped_gears:
		for stat_name in type_of_stats.keys():
			if gear != null:
				var bonus = gear.gear_value.get(stat_name, 0)
				if bonus is int or bonus is float:
					self.set(stat_name, self.get(stat_name) + bonus)
	
func add_skill(skill):
	skill_set.append(skill)
	
func SetHealthSlider() -> int:
	return (self.char_life * 100 / (self.char_max_life))
