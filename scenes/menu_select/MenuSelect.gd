extends Control

export (PackedScene) var LevelButton
onready var Left = $HBoxContainer/Left
onready var Right = $HBoxContainer/Right
onready var Main = $HBoxContainer2/Main
onready var Levels = $Panel/ScrollContainer/CenterContainer/Levels
onready var WorldName = $HBoxContainer/WorldName
var levels_path = "res://scenes/levels/"
var worlds_list = []
var pointer = 0

func _ready():
	Left.set_texture("res://assets/images/arrowLeft.png")
	Right.set_texture("res://assets/images/arrowRight.png")
	Main.set_texture("res://assets/images/home.png")
	setup_worlds_list()
	setup_levels(worlds_list[pointer])

func setup_worlds_list():
	var dir = Directory.new()
	dir.open(levels_path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			if file_name != ".." and file_name != ".":
				worlds_list.append(file_name)
		file_name = dir.get_next()

func setup_levels(world):
	WorldName.text = world
	var to_free = Levels.get_children()
	if to_free.size() > 0:
		for child in to_free:
			child.queue_free()
	
	var path = levels_path + world + "/"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir():
			if file_name != ".." and file_name != ".":
				var new_button = LevelButton.instance()
				new_button.level = path + file_name
				new_button.level_name = file_name
				new_button.world = world
				#new_button.stars = # TODO: añadir estrellas
				Levels.add_child(new_button)
		file_name = dir.get_next()
