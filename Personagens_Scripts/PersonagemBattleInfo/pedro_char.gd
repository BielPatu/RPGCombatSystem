extends Char

var SkillDB = [preload("res://Skills/Tackle/tackle.gd")]

func _init() -> void:
	var base_char_name = "Pedro Cabloco"
	var base_char_damage = 4
	var base_char_defense = 15
	var base_char_life = 400
	var base_char_max_life = 400
	var base_char_level = 1
	var base_char_critical_blow = 12
	
	
	
	
	
	
	char_name = "Pedro Cabloco"
	char_damage = 4
	char_defense = 15
	char_life = 400
	char_max_life = 400
	char_level = 1
	char_critical_blow = 12
	learnable_skill_moves = SkillDB
	skill_set = []
	char_character_image = preload("res://Sprites/Pedro_Battle_Sprite.jpg") as Texture2D
	char_type = "playable_ally"
	

func get_save_data() -> Dictionary:
	var skill_names = []
	for skill in skill_set:
		skill_names.append(skill.skill_name) 

	return {
		"char_name": char_name,
		"char_level": char_level,
		"char_life": char_life,
		"char_max_life": char_max_life,
		"char_damage": char_damage,
		"char_defense": char_defense,
		"char_critical_blow": char_critical_blow,
		"char_type": char_type,
		"skills": skill_names,
		"class_id": "Pedro" 
	}

func load_save_data(data: Dictionary) -> void:
	char_name = data.get("char_name", char_name)
	char_level = data.get("char_level", char_level)
	char_life = data.get("char_life", char_life)
	char_max_life = data.get("char_max_life", char_max_life)
	char_damage = data.get("char_damage", char_damage)
	char_defense = data.get("char_defense", char_defense)
	char_critical_blow = data.get("char_critical_blow", char_critical_blow)
	char_type = data.get("char_type", char_type)

	skill_set.clear()
	for skill_name in data.get("skills", []):
		for skill in learnable_skill_moves:
			var instance = skill.new()
			if instance.skill_name == skill_name:
				add_skill(instance)




func _ready() -> void:
	for x in learnable_skill_moves:
		x = x.new()
		add_skill(x)
		
	
