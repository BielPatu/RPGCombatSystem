extends Status

class_name Nausea

func _init() -> void:
	status_name = 'Nausea I'
	status_value = 70
	status_turn_duration = 2

func activate(_user, _target, value, battleSceneController, prompt):
	if !is_status_activated:
		user = _user
		target = _target
		update_status_dictionary()
		update_skill_dictionary()
		
		for t in target:
			for x in t.skill_set:
				x.skill_chance = max(10, x.skill_chance - (x.skill_chance * self.status_value / 100.0))
			var calc = t.char_evasion - (self.status_value/2)
			t.char_evasion = calc
		
		battleSceneController.activatedStatusEffects.append(self)
		which_turn_ends = battleSceneController.turn + self.status_turn_duration
		is_status_activated = true
			

		
	
	
	
