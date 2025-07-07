extends Char


class_name porta

var SkillDB = [preload("res://Skills/Vinas Approaches/vinas_approaches.gd")]


func _init() -> void:
	char_name = "Porta de madeira"
	char_damage = 0
	char_critical_blow = 99
	char_evasion = 33
	char_level = 1
	char_max_life = 2300
	char_life = 2300
	learnable_skill_moves = SkillDB
	char_character_image = preload("res://Sprites/Porta_Madeira_Battle_Sprite.png") as Texture2D
	char_type = "playable_ally"
	skill_set = []
	
	
func _ready() -> void:
	for x in learnable_skill_moves:
		x = x.new()
		add_skill(x)
		
	
func add_skill(skill):
	skill_set.append(skill)
	print(skill_set[0].skill_name)		
	
	
	
