extends CanvasLayer

onready var Level = $HUD/HBoxContainer/Level
onready var Push = $HUD/HBoxContainer/Push
var push = 0
var total_push = 0
func _ready():
	Level.text = "World: " + Global.level.world + " Level: " + Global.level.name

func update_push():
	Push.text = "Push: " + str(push) + "/" + str(total_push)

func add_push():
	push += 1
	update_push()
