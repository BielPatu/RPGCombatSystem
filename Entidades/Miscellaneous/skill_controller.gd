extends Node2D


func _ready() -> void:
	var skill_scripts = load_all_skills("res://Skills/")

func load_all_skills(path: String) -> Array:
	var skills = []

	var dir = DirAccess.open(path)
	if dir == null:
		print("Não foi possível abrir o diretório: ", path)
		return skills

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if dir.current_is_dir():
			if file_name != "." and file_name != "..":
				var sub_skills = load_all_skills(path + "/" + file_name)
				skills += sub_skills
		else:
			if file_name.ends_with(".gd"):
				var full_path = path + "/" + file_name
				var skill_script = load(full_path)
				if skill_script != null:
					skills.append(skill_script)
		file_name = dir.get_next()

	dir.list_dir_end()
	return skills
