extends Node

var level = {
	name = "",
	path = "",
	world = "",
	push = 0
}

var stars = {
	Minicosmos = {
		factor = 1.3,
		stars = 0
	},
	Picocosmos = {
		factor = 1.5,
		stars = 0
	}
}

func _ready():
	if load_data("stars") != null:
		stars = load_data("stars")

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
