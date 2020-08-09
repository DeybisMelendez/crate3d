extends Control

onready var Play = $VBoxContainer/Play
onready var Shop = $VBoxContainer/Shop

func _ready():
	Play.connect("button_up", self, "play")

func play():
	get_tree().change_scene("res://scenes/menu_select/MenuSelect.tscn")
