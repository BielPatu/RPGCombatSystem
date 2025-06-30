extends Button

class_name SkillButton

var skill_name = ""
var skill = null
var battle_controller = null
var user = null

func _ready() -> void:
	battle_controller = get_parent().get_parent()
	self.text = skill_name

func _on_pressed() -> void:
	skill.activate(user, user, self.skill.skill_value)
	battle_controller.UpdateValues(user)
	battle_controller.promptText.text = ("{name} usou {skill}".format({"name": self.user.char_name, "skill": self.skill_name}))
