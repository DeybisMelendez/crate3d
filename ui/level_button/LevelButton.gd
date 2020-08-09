extends VBoxContainer
onready var Butn = $MarginContainer/Button
const LevelRender = "res://scenes/level_render/LevelRender.tscn"
var level_name = ""
var level = ""
var world = ""
var stars = 0
var stars_to_unlock = 0
var locked = false
func _ready():
	Butn.connect("button_up", self, "button_up")
	if stars > 0:
		for i in stars:
			$HBoxContainer.get_child(i).show()
	if stars_to_unlock <= Global.stars[world].stars:
		Butn.text = level_name
		$MarginContainer/Button/Star.hide()
	else:
		locked = true
		var blocked_style = load("res://styles/buttons/level_blocked_normal.tres")
		Butn.set("custom_styles/normal", blocked_style)
		Butn.set("custom_styles/pressed", blocked_style)
		Butn.set("custom_styles/hover", blocked_style)
		Butn.text = str(stars_to_unlock)
		$AcceptDialog.dialog_text = "You need " + str(stars_to_unlock) + " stars to play this level!"

func button_up():
	if locked:
		$AcceptDialog.popup_centered()
	else:
		Global.level.name = level_name
		Global.level.world = world
		Global.level.path = level
		print(level)
		get_tree().change_scene(LevelRender)
