extends Node2D

class_name Battle

@onready var Unit = preload("res://Cenas/Cenas_Personagens/Personagens/Eloi_Char.tscn")
@onready var playerButton = preload("res://Cenas/skill.tscn")
@onready var playerImagePosition = $player_sprite

@onready var combatGrid = $player_skill_grid
@onready var prompt = preload("res://Cenas/battlePrompt.tscn")

var promptText = ''

func _ready() -> void:
	
	instantiatePlayer()
	instantiatePrompt()
	
func instantiatePlayer() ->void:
	var player = Unit.instantiate()
	add_child(player)
	player.char_life_slider = $player_lifeBar
	player.char_label_name = $player_name
	playerImagePosition.texture = player.char_character_image
	LoadPlayerInfo(player)
	
func instantiatePrompt() -> void:
	promptText = prompt.instantiate()
	promptText.position = $prompt.position
	add_child(promptText)
		
	
		
func LoadPlayerInfo(player) -> void:
	player.char_life_slider = $player_lifeBar
	player.char_label_name = $player_name

	player.char_life_slider.value = player.SetHealthSlider()
	player.char_label_name.text = player.char_name
	
	
	for i in player.skill_set:
		var skillButton =  playerButton.instantiate()
		skillButton.skill_name = i.skill_name
		skillButton.skill = i
		skillButton.user = player
		combatGrid.add_child(skillButton)

	
func UpdateValues(player) -> void:
	player.char_life_slider.value = player.SetHealthSlider()
