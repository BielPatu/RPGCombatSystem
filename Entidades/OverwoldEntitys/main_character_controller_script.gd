extends Node
class_name characterOverall

var character_classes := {
	"Eloi": preload("res://Cenas/Cenas_Personagens/Personagens/Eloi_Char.tscn"),
	"Pedro": preload("res://Cenas/Cenas_Personagens/Personagens/Pedro_Char.tscn")
}

var item_classes := {
	"Desodorante": preload("res://Items/Desodorante/desodorante_item.gd")
}


var party_scenes := [character_classes["Eloi"]] 

var loaded_party_instances := [] 
var inventory:= [item_classes["Desodorante"]]
var save_path := "user://savegame.json"


func save_game():
	var party_data := []
	for _char in party_scenes:
		var instance = _char.instantiate()
		if instance.has_method("get_save_data"):
			var savedCharacter = instance.get_save_data()
			party_data.append(savedCharacter)

	var save_data := {
		"party": party_data,
		"inventory": inventory
	}

	var file := FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	print("Jogo salvo com sucesso!")


func load_game() -> bool:
	if not FileAccess.file_exists(save_path):
		print("Nenhum save encontrado.")
		return false

	var file := FileAccess.open(save_path, FileAccess.READ)
	var content := file.get_as_text()
	file.close()

	var result = JSON.parse_string(content)
	if result is Dictionary:
		var save_data: Dictionary = result as Dictionary
		inventory = save_data.get("inventory", [])
		loaded_party_instances.clear()

		for char_data in save_data.get("party", []):
			var class_id = char_data.get("class_id", "")
			if character_classes.has(class_id):
				var char_scene = character_classes[class_id]
				var char_instance = char_scene.instantiate()
				char_instance.load_save_data(char_data)
				loaded_party_instances.append(char_instance)

		print("Jogo carregado com sucesso!")
		return true
	else:
		print("Erro ao ler save.")
		return false
