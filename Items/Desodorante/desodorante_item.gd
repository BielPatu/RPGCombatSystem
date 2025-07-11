extends Item



func _init() -> void:
	item_name = "Desodorante Gamer"
	item_value = 75


func activate(_user, target, value, battle_controller, prompt):
	await prompt.animatedText("{user} usou {name} no {target}".format({"user":_user, "name":self.item_name, "target":target[0]}))
	var mainTarget = target[0]
	var beforeEnemy = mainTarget.char_life
	var BeforeplayerHeal = _user.char_life
	mainTarget.char_life = max(mainTarget.char_life - (self.item_value * 0.5), 0)
	var enemyDamage = beforeEnemy - mainTarget.char_life
	_user.char_life = min(_user.char_life + ((self.item_value * 0.5) / 2), _user.char_max_life)
	var playerHeal = (BeforeplayerHeal - _user.char_life) * -1  

	
	await battle_controller.UpdateValues(mainTarget, enemyDamage)
	await battle_controller.UpdateValues(_user, playerHeal)
