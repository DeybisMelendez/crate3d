extends KinematicBody
const SPEED = 10
const ROT_SPEED = 4
var mov = Vector3.ZERO
onready var Cam = $Camera

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		Cam.rotation.y -= ROT_SPEED * delta
	elif Input.is_action_pressed("ui_left"):
		Cam.rotation.y += ROT_SPEED * delta
	if Input.is_action_pressed("ui_up"):
		mov = Vector3(sin(Cam.rotation.y+PI), 0, cos(Cam.rotation.y+PI))
	elif Input.is_action_pressed("ui_down"):
		mov = Vector3(sin(Cam.rotation.y), 0, cos(Cam.rotation.y))
	else:
		mov = Vector3.ZERO
	move_and_slide(mov*SPEED)
