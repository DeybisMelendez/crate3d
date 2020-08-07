extends Node

var level = {
	name = "",
	path = "",
	world = ""
}

var total_stars = 0
const factor_star = {
	Minicosmos = 1.2,
	Picocosmos = 1.5
}

func _ready():
	total_stars = load_data("total_stars")
	if total_stars == null:
		total_stars = 1

func save_data(data, file_name):
	var file = File.new()
	file.open("user://" + file_name + ".sav",file.WRITE)
	file.store_var(data)
	file.close()

func load_data(file_name):
	var file = File.new()
	var path = "user://" + file_name + ".sav"
	if not file.file_exists(path):
		return
	file.open(path, file.READ)
	var content = file.get_var()
	file.close()
	return content
