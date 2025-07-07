extends Char

var SkillDB = [preload("res://Skills/Tackle/tackle.gd")]

func _init() -> void:
	char_name = "Pedro Cabloco"
	char_damage = 6
	char_defense = 15
	char_life = 400
	char_max_life = 400
	char_level = 1
	learnable_skill_moves = SkillDB
	skill_set = []
	char_character_image = preload("res://Sprites/Pedro_Battle_Sprite.jpg") as Texture2D
	char_type = "playable_ally"
	char_critical_blow = 12


func _ready() -> void:
	for x in learnable_skill_moves:
		x = x.new()
		add_skill(x)
		
	
func add_skill(skill):
	skill_set.append(skill)	
