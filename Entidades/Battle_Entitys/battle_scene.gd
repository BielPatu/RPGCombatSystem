extends Node2D

class_name BattleStage





@onready var enemyDB = preload("res://Personagens_Scripts/PersonagemOverwoldInfo/pedro_overworld_npc.gd")

@onready var Unit = []

@onready var AllyUnitLifeBar = [$player_lifeBar, $ally_lifeBar, $ally_lifeBar2, $ally_lifeBar3]
@onready var AllyUnitNameLabel = [$player_name, $ally_name, $ally_name2, $ally_name3]

@onready var EnemyUnitLifeBar = [$enemy_lifeBar]
@onready var EnemyUnitNameLabel = [$enemy_name]

@onready var AllyUnitSprite = [$player_sprite, $ally_sprite, $ally_sprite2, $ally_sprite3]
@onready var EnemyUnitSprite = [$enemy_sprite]
@onready var floatingDamage = [$playerFloatingDamage, $enemyFloatingDamage]

@onready var playerButton = preload("res://Cenas/skill.tscn")
@onready var itemButton = preload("res://Cenas/item.tscn")
@onready var damageNumber = preload("res://Cenas/damage_number.tscn")

@onready var ActionButtons = [$player_menu/Button, $player_menu/AbilityToggleButton, $player_menu/InventoryButton, $player_menu/Button4]
@onready var AbilityToggleButton = $player_menu/AbilityToggleButton



var units = []
var playableunits = []
var unplayableunits = []
var player
var enemy
var rng = RandomNumberGenerator.new()
var damageNumberInstance
var turn = 1
var index = 0
var activatedStatusEffects = []

@onready var combatGrid = $player_skill_grid
@onready var menuGrid = $player_menu
@onready var prompt = preload("res://Cenas/battlePrompt.tscn")

var promptText = ''

enum BattleState { PLAYER_TURN, EXTRA_PLAYER_TURN, ENEMY_TURN, EXTRA_ENEMY_TURN }
var currentState: BattleState = BattleState.PLAYER_TURN

func _ready() -> void:
	var save_loaded = MainCharacterDatabase.load_game()
	if not save_loaded:
		MainCharacterDatabase.loaded_party_instances = [
			MainCharacterDatabase.character_classes["Eloi"].instantiate(),
			MainCharacterDatabase.character_classes["Pedro"].instantiate()
		]
	LoadCharactersInfo()

func LoadCharactersInfo() -> void:
	for partyMember in MainCharacterDatabase.loaded_party_instances:
		add_child(partyMember)
		Unit.append(partyMember)
	var enemyDataBase = enemyDB.new()
	for partyMember in enemyDataBase.party:
		var instance = partyMember.instantiate()
		add_child(instance)
		Unit.append(instance)


	await instantiateUnit()
	await instantiatePrompt()
	
	player = playableunits[0]
	enemy = unplayableunits[0]


func instantiateUnit() -> void:
	var allyIndex = 0
	var enemyIndex = 0

	for i in range(Unit.size()):
		var instance = Unit[i]
		units.append(instance)

		if instance.char_type == "playable_ally":
			instance.char_life_slider = AllyUnitLifeBar[allyIndex]
			instance.char_label_name = AllyUnitNameLabel[allyIndex]
			AllyUnitSprite[allyIndex].texture = instance.char_character_image
			playableunits.append(instance)
			LoadPlayerInfo(instance)
			allyIndex += 1
		elif instance.char_type == "unplayable_enemy":
			instance.char_life_slider = EnemyUnitLifeBar[enemyIndex]
			instance.char_label_name = EnemyUnitNameLabel[enemyIndex]
			EnemyUnitSprite[enemyIndex].texture = instance.char_character_image
			unplayableunits.append(instance)
			LoadEnemyInfo(instance)
			enemyIndex += 1

func instantiatePrompt() -> void:
	promptText = prompt.instantiate()
	promptText.position = $prompt.position
	add_child(promptText)

func LoadPlayerInfo(player) -> void:
	player.char_life_slider.value = player.SetHealthSlider()
	player.char_label_name.text = player.char_name

func LoadButtonInfo(playerIndex) -> void:
	for button in combatGrid.get_children():
		combatGrid.remove_child(button)
	for i in playableunits[playerIndex].skill_set:
		var btn = playerButton.instantiate()
		btn.skill_name = i.skill_name
		btn.skill = i
		btn.user = playableunits[playerIndex]
		btn.battle_controller = self
		combatGrid.add_child(btn)
		
		
func LoadInventoryInfo(playerIndex) -> void:
	for button in combatGrid.get_children():
		combatGrid.remove_child(button)
	for items in MainCharacterDatabase.inventory:
		var btn = itemButton.instantiate()
		var item = items.new()
		btn.item = item
		btn.item_name = item.item_name
		btn.user = playableunits[playerIndex]
		btn.battle_controller = self
		combatGrid.add_child(btn)


func UnloadButtonInfo() -> void:
	for button in combatGrid.get_children():
		combatGrid.remove_child(button)

func LoadEnemyInfo(enemy) -> void:
	enemy.char_life_slider.value = enemy.SetHealthSlider()

func UpdateValues(_unit, damage) -> void:
	var labels = []
	var tween = get_tree().create_tween()
	var characterHealthBar = _unit.char_life_slider
	if _unit.char_max_life != 0:
		var calc = (_unit.char_life * 100.0) / _unit.char_max_life
		if characterHealthBar:
			var bar = _unit.char_life_slider
			if damage > 0:
				characterHealthBar.shake_bar(damage, _unit.char_max_life, _unit.char_life)
			var dmg_label = damageNumber.instantiate()
			dmg_label.text = String.num(damage, 0)
			dmg_label.position = bar.global_position + Vector2(0, -20)
			add_child(dmg_label)
			labels.append(dmg_label)
			tween.tween_property(characterHealthBar, "value", calc, 0.4)
			await get_tree().create_timer(1.0).timeout
			for label in labels:
				remove_child(label)

func UpdateAllValues(damaged_units: Array) -> void:
	var tween = get_tree().create_tween()
	var labels = []
	for entry in damaged_units:
		var unit = entry["unit"]
		var damage = entry["damage"]

		if unit.char_max_life > 0:
			var bar = unit.char_life_slider
			var calc = (unit.char_life * 100.0) / unit.char_max_life

			if bar:
				if damage > 0:
					bar.shake_bar(damage, unit.char_max_life, unit.char_life)
					tween.tween_property(bar, "value", calc, 0.1)

				var dmg_label = damageNumber.instantiate()
				if damage == 0:
					dmg_label.text = "Esquivou"
				else:
					dmg_label.text = String.num(damage, 0)
				dmg_label.position = bar.global_position + Vector2(0, -20)
				add_child(dmg_label)
				labels.append(dmg_label)

	await get_tree().create_timer(1.0).timeout

	for label in labels:
		remove_child(label)

func TurnBattle() -> void:
	await UnloadButtonInfo()
	var playerTurn = (currentState == BattleState.PLAYER_TURN)
	for button in combatGrid.get_children():
		button.disabled = not playerTurn
	for button in menuGrid.get_children():
		button.disabled = not playerTurn


func LoadMenuButtons() -> void:
	for buttons in menuGrid.get_children():
		buttons.disabled = false


func increasePlayerIndex() -> void:
	await get_tree().create_timer(0.2).timeout
	if index == (playableunits.size() - 1):
		switchButtonValues()
		index = 0
		EndPlayerTurn()
		return
	await UnloadButtonInfo()
	index+=1
	await promptText.animatedText("{name} se prepara para seu proximo movimento".format({"index": index, "name": playableunits[index].char_name}))
	switchButtonValues()
	LoadMenuButtons()
	
	
func switchButtonValues() -> void:
	if ActionButtons[1].switch:
		ActionButtons[1].switchValues()
	if ActionButtons[2].switch:
		ActionButtons[2].switchValues()	


	
func EndPlayerTurn() -> void:
	index = 0
	currentState = BattleState.ENEMY_TURN
	TurnBattle()

	EnemyTurn()

func UnloadAllButtons() ->void :
	for button in combatGrid.get_children():
		button.disabled = true
	for button in menuGrid.get_children():
		button.disabled = true
	

func UnloadMenuButtons() -> void:
	for button in menuGrid.get_children():
			button.disabled = true
			
func EnemyTurn() -> void:
	await get_tree().create_timer(0.3).timeout

	var skillIndex = EnemyRandomChoice(enemy)
	var chosenSkill = enemy.skill_set[skillIndex]

	if chosenSkill.is_AOE:
		var beforeHP = {}
		for target in playableunits:
			beforeHP[target] = target.char_life

		await chosenSkill.activate(enemy, playableunits, chosenSkill.skill_value, self, promptText)

		var allDamaged = []
		for target in playableunits:
			var damage = beforeHP[target] - target.char_life
			allDamaged.append({ "unit": target, "damage": damage })

		UpdateAllValues(allDamaged)
	else:
		var playerTarget = playableunits[rng.randi_range(0, playableunits.size() - 1)]
		var playerBeforeDamage = playerTarget.char_life
		await chosenSkill.activate(enemy, [playerTarget], chosenSkill.skill_value, self, promptText)
		var damage = playerBeforeDamage - playerTarget.char_life
		await wasTargetDamaged(playerTarget, playerBeforeDamage, damage)

	currentState = BattleState.PLAYER_TURN
	verifyStatusEffects()
	turn+=1
	TurnBattle()
	
func EnemyRandomChoice(enemy) -> int:
	return rng.randi_range(0, enemy.skill_set.size() - 1)

#func instantiateFloatingDamage(calc, unit) -> void:
#	damageNumberInstance = damageNumber.instantiate()
#	damageNumberInstance.text = str(calc)
#	damageNumberInstance.position = unit.char_life_slider.global_position + Vector2(0, -20)
#	add_child(damageNumberInstance)
#	await get_tree().create_timer(1.0).timeout
#	remove_child(damageNumberInstance)

func wasTargetDamaged(unit, beforeHealth, damage) -> void:
	if unit.char_life < beforeHealth:
		await UpdateValues(unit, damage)

func verifyStatusEffects() -> void:
	if activatedStatusEffects != null:
		for effects in activatedStatusEffects:
			if effects.verifyTurn(self):
				activatedStatusEffects.pop_at(activatedStatusEffects.find(effects, 0))
				
			
func isStatusAlreadyActive(status_name: String, target) -> bool:
	for effect in activatedStatusEffects:
		if effect.status_name == status_name and effect.target.has(target):
			return true
	return false
