extends Char

#Deixa Peronsagens com efeito de Atordoado(Concede Liz turnos extras aleatorios)
#Chicoteia Inimigos com seus cabelos - AOE
#Torção do espaço - Causa NauseaII(-50% chance de acerto), VulnerabilidadeII, Chance de aplicar loucura(+300% chance de acerto)

func _init() -> void:
	char_name = "Flor d' Liz"
	char_damage = 8
	char_life = 2500
	char_max_life = 2500
	char_level = 1
	learnable_skill_moves = SkillDB
	skill_set = []
	char_character_image = preload("res://Sprites/Pedro_Battle_Sprite.jpg") as Texture2D
	char_type = "unplayable_enemy"
	char_critical_blow = 1
