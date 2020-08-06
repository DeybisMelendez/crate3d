extends VBoxContainer
const LevelRender = "res://scenes/level_render/LevelRender.tscn"
var level_name = ""
var level = ""
var world = ""
var stars = 0
func _ready():
	$MarginContainer/Button.connect("button_up", self, "button_up")
	if stars > 0:
		for i in stars:
			$HBoxContainer.get_child(i-1).show()
	#level_name.erase(level_name.length()-4,4)
	$MarginContainer/Button.text = level_name

func button_up():
	Global.level.name = level_name
	Global.level.world = world
	Global.level.path = level
	print(level)
	get_tree().change_scene(LevelRender)
