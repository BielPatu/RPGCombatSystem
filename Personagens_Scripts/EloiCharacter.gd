extends Char

class_name Eloi

var SkillDB = [preload("res://Skills/Tackle/tackle.gd"), preload("res://Skills/Enduring/enduring.gd"), preload("res://Skills/Quick Team/quick_team.gd")]

func _init() -> void:
	char_name = "Eloi"
	char_damage = 5
	char_defense = 25
	char_life = 200
	char_max_life = 200
	char_level = 1
	learnable_skill_moves = SkillDB
	skill_set = []
	char_character_image = preload("res://Sprites/Eloi_Battle_Sprite.jpg") as Texture2D
	
	
func _ready() -> void:
	for x in learnable_skill_moves:
		x = x.new()
		add_skill(x)
		
	
func add_skill(skill):
	skill_set.append(skill)	

	
	
