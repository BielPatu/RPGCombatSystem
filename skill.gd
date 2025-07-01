extends Button

class_name SkillButton

var skill_name = ""
var skill = null
var battle_controller = null
var user = null
var target = null

func _ready() -> void:
	battle_controller = get_parent().get_parent()
	self.text = skill_name

func _on_pressed() -> void:
	target = battle_controller.enemy
	var targetbf = target.char_life
	skill.activate(user, target, skill.skill_value)
	damageVerifier(targetbf, target.char_life)
	battle_controller.promptText.text = ("{name} usou {skill}".format({"name": self.user.char_name, "skill": self.skill_name}))
	battle_controller.EndPlayerTurn(user)  

func damageVerifier(targetBeforeDamage, targetAfterDamage) -> void:
	var calc = targetBeforeDamage - targetAfterDamage
	if targetAfterDamage < targetBeforeDamage:
		battle_controller.instantiateFloatingDamage(calc)
		battle_controller.UpdateValues(target)
