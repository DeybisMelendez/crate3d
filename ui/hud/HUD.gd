extends CanvasLayer

onready var Level = $HUD/HBoxContainer/Level
onready var Push = $HUD/HBoxContainer/Push
onready var WinMenu = $WinMenu
onready var Levels = $WinMenu/Levels
onready var Main = $WinMenu/Main
onready var Restart = $WinMenu/Restart

var push = 0
var total_push = 0
func _ready():
	Level.text = "World: " + Global.level.world + " Level: " + Global.level.name
	Levels.connect("button_up", self, "levels")
	Main.connect("button_up", self, "main")
	Restart.connect("button_up", self, "restart")

func update_push():
	Push.text = "Push: " + str(push) + "/" + str(total_push)

func add_push():
	push += 1
	update_push()

func show_WinMenu():
	get_tree().paused = true
	WinMenu.show()
	$HUD.hide()
	var stars = 1
	if push == Global.level.push:
		for i in $WinMenu/HBoxContainer.get_children():
			i.show()
		stars = 3
	elif push >= Global.level.push*1.5:
		var i = $WinMenu/HBoxContainer.get_children()
		i[0].show()
		i[1].show()
		stars = 2
	else:
		$"WinMenu/HBoxContainer/0".show()
	#TODO determinar si el jugador ya obtuvo sus estrellas!
	Global.stars[Global.level.world].stars += stars
	Global.save_data(Global.stars, "stars")

func levels():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/menu_select/MenuSelect.tscn")

func main():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/main/Main.tscn")

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
