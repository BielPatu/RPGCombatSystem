extends Char

#Persona = Ganha turno extra - Pelo turno que foi ativado aumenta evasão para 70%
#Katana espiritual - Muito dano
#Sistematico - conforme os turnos passam as habilidades dos oponentes são reduzidas em 6%, 12%, 18%, 24%, 30%, 36%, 42%, 48%, 50%
#Perspectiva - Você pega 50% do dano do seu aliado pelos proximos 5 turnos(Você não pode morrer para essa habilidade)

func _init() -> void:
	char_name = "Hugo"
	char_damage = 8
	char_defense = 7
	char_life = 90
	char_max_life = 90
	char_level = 1
	learnable_skill_moves = SkillDB
	skill_set = []
	char_character_image = preload("res://Sprites/Pedro_Battle_Sprite.jpg") as Texture2D
	char_type = "unplayable_enemy"
	char_critical_blow = 44
