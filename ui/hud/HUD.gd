extends Control

onready var Level = $HBoxContainer/Level
onready var Push = $HBoxContainer/Push

func _ready():
	Level.text = "World: " + Global.level.world + " Level: " + Global.level.name

func update_push(push, total_push):
	Push.text = "Push: " + str(push) + "/" + str(total_push)
