extends Char

var SkillDB = [preload("res://Skills/Tackle/tackle.gd"), preload("res://Skills/Enduring/enduring.gd"), preload("res://Skills/Quick Team/quick_team.gd")]

func _init() -> void:
	char_name = "Pedro Cabloco"
	char_damage = 15
	char_defense = 55
	char_life = 400
	char_max_life = 400
	char_level = 5
	learnable_skill_moves = SkillDB
	skill_set = []
	char_character_image = preload("res://Sprites/Pedro_Battle_Sprite.jpg") as Texture2D


func _ready() -> void:
	for x in learnable_skill_moves:
		x = x.new()
		add_skill(x)
		
	
func add_skill(skill):
	skill_set.append(skill)	
