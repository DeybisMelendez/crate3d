extends MarginContainer

signal button_pressed

func _ready():
	$Button.connect("button_up",self, "button_up")

func button_up():
	emit_signal("button_pressed")

func set_texture(texture):
	$Button/TextureRect.texture = load(texture)
