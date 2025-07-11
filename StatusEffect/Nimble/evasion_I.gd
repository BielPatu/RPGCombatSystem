extends Status

class_name Evasion

func _init() -> void:
	status_name = "Evasion I"
	status_turn_duration = 2
	status_value = 33

func activate(_user, _target, value, battleSceneController, prompt):
	if is_status_activated:
		return
	user = _user
	target = _target
	update_status_dictionary()
	update_skill_dictionary()
	var calc = user.char_evasion - (self.status_value/2)
	user.char_evasion = calc
	battleSceneController.activatedStatusEffects.append(self)
	which_turn_ends = battleSceneController.turn + self.status_turn_duration
	is_status_activated = true
