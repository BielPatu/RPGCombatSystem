extends Button

class_name ItemButton

var item_name = ""
var item = null
var battle_controller = null
var user = null
var target = null

func _ready() -> void:
	battle_controller = get_parent().get_parent()
	self.text = item_name

func _on_pressed() -> void:
###if skill.is_AOE:
##var targets = battle_controller.unplayableunits
#var targets_before = targets.map(func(t): return t.char_life)
#battle_controller.UnloadAllButtons()
#await skill.activate(user, targets, skill.skill_value, battle_controller, battle_controller.promptText)
#await battle_controller.get_tree().create_timer(0.2).timeout

#for i in range(targets.size()):
#	damageVerifier(targets[i], targets_before[i], targets[i].char_life)
#else:
	target = battle_controller.unplayableunits[0]
	var targetbf = target.char_life
	battle_controller.UnloadAllButtons()
	await item.activate(user, [target], item.item_value, battle_controller, battle_controller.promptText)
	await battle_controller.get_tree().create_timer(0.).timeout
	await battle_controller.increasePlayerIndex()
