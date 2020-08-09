extends CanvasLayer

onready var Level = $HUD/HBoxContainer/Level
onready var Push = $HUD/HBoxContainer/Push

func _ready():
	Level.text = "World: " + Global.level.world + " Level: " + Global.level.name

func update_push(push, total_push):
	Push.text = "Push: " + str(push) + "/" + str(total_push)
