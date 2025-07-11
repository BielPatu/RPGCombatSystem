extends Char

class_name Eloi

var SkillDB = [preload("res://Skills/Enduring/enduring.gd"), preload("res://Skills/Quick Team/quick_team.gd")]

func _init() -> void:
	var base_char_name = "Eloi"
	var base_char_damage = 3
	var base_char_defense = 15
	var base_char_life = 200
	var base_char_max_life = 200
	var base_char_level = 1
	var base_char_critical_blow = 10
	
	
	char_name = "Eloi"
	char_damage = 3
	char_defense = 15
	char_life = 200
	char_max_life = 200
	char_level = 1
	learnable_skill_moves = SkillDB
	skill_set = []
	char_character_image = preload("res://Sprites/Eloi_Battle_Sprite.jpg") as Texture2D
	char_critical_blow = 10
	char_type = "playable_ally"
	var gear_resource = [preload("res://Gear/Amuleto do Egoista/egoismo_gear.gd"), preload("res://Gear/Chicote de Espinhos/espinhos_gear.gd"), preload("res://Gear/Casca de Tartaruga/tartaruga_gear.gd")]
	for equip_gears in gear_resource:
		equipped_gears.append(equip_gears.new())
	
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
		"class_id": "Eloi" 
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
	
	
	calculate_total_stats()
	verifyMaxHealth()

func verifyMaxHealth() -> void:
	if self.char_life > self.char_max_life:
		char_life = char_max_life

	
	
