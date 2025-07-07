extends Char

#SangueSuga - Rouba Vida 
#Operação- Dano, Chance de Nausea(-25% Precisão), Chance de Desconforto(-5% dano, -35% Taxa Critica), Vulnerabilidade I(-20 de Defesa)
#Dança da morte- VulneralibidadeII(-100% de Defesa) e Aumenta dano recebido em 55% pelos proximos 5 turnos, 	
var SkillDB = [preload("res://Skills/Chicoteada Ondulada/chicoteada.gd")]

func _init() -> void:
	char_name = "Vinas"
	char_damage = 13
	char_defense = 55
	char_life = 1000
	char_max_life = 1000
	char_level = 1
	learnable_skill_moves = SkillDB
	skill_set = []
	char_character_image = preload("res://Sprites/vinas_phase1_battle_sprite.jpg") as Texture2D
	char_type = "unplayable_enemy"
	char_critical_blow = 1


func _ready() -> void:
	for x in learnable_skill_moves:
		x = x.new()
		add_skill(x)
		
	
func add_skill(skill):
	skill_set.append(skill)	
