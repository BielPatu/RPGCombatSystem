extends SkillButton

class_name Basic_Attack


@onready var ataqueBasico = preload("res://Skills/Tackle/tackle.gd")

func _ready() -> void:
	battle_controller = get_parent().get_parent()
	self.text = skill_name
	skill = ataqueBasico.new()
	

func _init() -> void:
	skill_name = "Ataque B."

func _on_pressed() -> void:
	user = battle_controller.playableunits[battle_controller.index]
	target = battle_controller.unplayableunits[0]
	var targetbf = target.char_life
	battle_controller.UnloadAllButtons()
	await skill.activate(user, [target], skill.skill_value, battle_controller, battle_controller.promptText)
	damageVerifier(target, targetbf, target.char_life)
	await battle_controller.get_tree().create_timer(0.3).timeout
	await battle_controller.increasePlayerIndex()

func damageVerifier(unit, targetBeforeDamage, targetAfterDamage) -> void:
	var calc = targetBeforeDamage - targetAfterDamage
	if targetAfterDamage < targetBeforeDamage:
		battle_controller.UpdateValues(unit, calc)
