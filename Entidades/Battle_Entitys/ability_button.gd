extends Button

var battle_controller
var switch = false


func _ready() -> void:
	battle_controller = get_parent().get_parent()

func _on_pressed() -> void:
	switchValues()
	
func switchValues() -> void:
	if !switch:
		battle_controller.LoadButtonInfo(battle_controller.index)
		for button in battle_controller.menuGrid.get_children():
			button.disabled = true
			if button == self:
				button.disabled = false
		switch = true
	elif switch:
		battle_controller.UnloadButtonInfo()
		for button in battle_controller.menuGrid.get_children():
			button.disabled = false
			
		switch = false	
