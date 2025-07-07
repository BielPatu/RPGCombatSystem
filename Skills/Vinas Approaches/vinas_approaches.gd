extends Skill

class_name vinas_attack

func _init() -> void:
	skill_name = ''
	buff_round_start_status = false
	

func activate(user, target, value, battleSceneController, prompt) -> void:
	var promptRandom = [
		"A sensação de desespero corrói sua pele, é como se sua vida estivesse por um fio",
		"É como se tivesse alguém no canto de sua visão, esperando atentamente a sua próxima falha",
		".......... Fugir não parece possível"
	]
	var talks = [
		"Você sente que precisa passar por essa porta",
		"Algo ruim se aproxima, mas não consegues dizer o que."
	]

	if !is_skill_buff_active:
		await prompt.animatedText(talks[0]) 
		await battleSceneController.get_tree().create_timer(1.5).timeout
		await prompt.animatedText(talks[1]) 
		is_skill_buff_active = true
	else:
		prompt.animatedText(promptRandom[randi_range(0, 2)]) 
		
