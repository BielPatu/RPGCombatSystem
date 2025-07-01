extends Node2D

class_name Battle

@onready var Unit = [
	preload("res://Cenas/Cenas_Personagens/Personagens/Eloi_Char.tscn"),
	preload("res://Cenas/Cenas_Personagens/Personagens/pedro_char.tscn") 
]

@onready var UnitLifeBar = [$player_lifeBar, $enemy_lifeBar]
@onready var UnitNameLabel = [$player_name, $enemy_name]
@onready var UnitSprite = [$player_sprite, $enemy_sprite]
@onready var floatingDamage = [$playerFloatingDamage, $enemyFloatingDamage]

@onready var playerButton = preload("res://Cenas/skill.tscn")
@onready var damageNumber = preload("res://Cenas/damage_number.tscn")


var units = []  
var player 
var enemy
var isEnemyInstantiated = false
var skillButton = null
var rng = RandomNumberGenerator.new()
var damageNumberInstance


@onready var combatGrid = $player_skill_grid
@onready var prompt = preload("res://Cenas/battlePrompt.tscn")

var promptText = ''

enum BattleState { PLAYER_TURN, EXTRA_PLAYER_TURN, ENEMY_TURN, EXTRA_ENEMY_TURN }

var currentState: BattleState = BattleState.PLAYER_TURN


func _ready() -> void:
	
	instantiateUnit()
	instantiatePrompt()
	
func instantiateUnit() -> void:
	for i in range(Unit.size()):
		var instance = Unit[i].instantiate()
		add_child(instance)
		instance.char_life_slider = UnitLifeBar[i]
		instance.char_label_name = UnitNameLabel[i]
		UnitSprite[i].texture = instance.char_character_image
		units.append(instance)
		
		if instance.char_name == 'Eloi':
			player = instance
			LoadPlayerInfo(player)
		if instance.char_name == 'Pedro Cabloco':
			enemy = instance
			LoadEnemyInfo(enemy)	
			

	
func instantiatePrompt() -> void:
	promptText = prompt.instantiate()
	promptText.position = $prompt.position
	add_child(promptText)
		
	
		
func LoadPlayerInfo(player) -> void:
	player.char_life_slider.value = player.SetHealthSlider()
	player.char_label_name.text = player.char_name

	for i in player.skill_set:
		var btn = playerButton.instantiate()
		btn.skill_name = i.skill_name
		btn.skill = i
		btn.user = player
		btn.battle_controller = self
		combatGrid.add_child(btn)
		
func LoadEnemyInfo(enemy) -> void:
	enemy.char_life_slider.value = enemy.SetHealthSlider()
	enemy.char_label_name.text = enemy.char_name


func UpdateValues(player) -> void:
	player.char_life_slider.value = player.SetHealthSlider()
	for x in units:
		if x.char_name == player.char_name:
			for y in range(UnitLifeBar.size()):
				if x.char_name == units[y].char_name:
					UnitLifeBar[y].shake_bar()
				
	
	
func TurnBattle() -> void:
	for button in combatGrid.get_children():
		button.disabled = (currentState != BattleState.PLAYER_TURN)

	
func EndPlayerTurn(player) -> void:
	enemy.char_life_slider.value = enemy.SetHealthSlider()
	currentState = BattleState.ENEMY_TURN
	TurnBattle()
	
	await get_tree().create_timer(1.0).timeout
	EnemyTurn()

func EnemyTurn() -> void:
	var playerTarget = units[0]
	var randomSkillNumber = EnemyRandomChoice(enemy)
	var playerBeforeDamage = playerTarget.char_life
	enemy.skill_set[randomSkillNumber].activate(enemy, playerTarget, enemy.skill_set[randomSkillNumber].skill_value)
	if playerTarget.char_life < playerBeforeDamage:
		var calc = playerBeforeDamage - playerTarget.char_life
		instantiateFloatingDamage(calc)
		UpdateValues(playerTarget)
		
	promptText.text = ("{name} usou {skill}".format({"name": enemy.char_name, "skill": enemy.skill_set[randomSkillNumber].skill_name}))
	currentState = BattleState.PLAYER_TURN
	TurnBattle()

func EnemyRandomChoice(enemy) -> int:
	var my_random_number = rng.randf_range(0, len(enemy.skill_set))
	return my_random_number 
	
	
func instantiateFloatingDamage(calc) -> void:
	damageNumberInstance = damageNumber.instantiate()
	damageNumberInstance.text = ("{dano}".format({"dano": calc}))
	if currentState == BattleState.PLAYER_TURN:
		damageNumberInstance.position = floatingDamage[1].position
		
	else:
		damageNumberInstance.position = floatingDamage[0].position	
		
	
	add_child(damageNumberInstance)
	await get_tree().create_timer(1.0).timeout
	self.remove_child(damageNumberInstance)	
