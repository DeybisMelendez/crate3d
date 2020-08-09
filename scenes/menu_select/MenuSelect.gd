extends Control

export (PackedScene) var LevelButton
onready var Left = $HBoxContainer/Left
onready var Right = $HBoxContainer/Right
onready var Main = $HBoxContainer2/Main
onready var Levels = $Panel/ScrollContainer/CenterContainer/Levels
onready var WorldName = $HBoxContainer/WorldName
onready var Stars =  $HBoxContainer2/Panel/HBoxContainer/Stars
var levels_path = "res://scenes/levels/"
var worlds_list = []
var pointer = 0

func _ready():
	Left.set_texture("res://assets/images/arrowLeft.png")
	Right.set_texture("res://assets/images/arrowRight.png")
	Main.set_texture("res://assets/images/home.png")
	setup_worlds_list()
	setup_levels(worlds_list[pointer])
	Left.connect("button_pressed", self, "left_pressed")
	Right.connect("button_pressed", self, "right_pressed")

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
	var number_files = 0
	while file_name != "":
		if not dir.current_is_dir():
			if file_name != ".." and file_name != ".":
				number_files += 1
		file_name = dir.get_next()
	for i in number_files:
		var new_button = LevelButton.instance()
		new_button.level = path + str(i+1) + ".txt"
		new_button.level_name = str(i+1)
		new_button.world = world
		new_button.stars_to_unlock = ceil(i * Global.stars[world].factor)
		Levels.add_child(new_button)
	Stars.text = str(Global.stars[world].stars)

func left_pressed():
	if pointer > 0:
		pointer -= 1
	else:
		pointer = worlds_list.size()-1
	setup_levels(worlds_list[pointer])

func right_pressed():
	if pointer >= worlds_list.size() -1:
		pointer = 0
	else:
		pointer += 1
	setup_levels(worlds_list[pointer])
