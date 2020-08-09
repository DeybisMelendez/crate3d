extends StaticBody

var dir = Vector3.ZERO
var can_move = false
var is_moving = false
var walls = {
	forward = false,
	back = false,
	left = false,
	right = false
}
func _ready():
	$Forward.connect("body_entered", self, "forward_entered")
	$Back.connect("body_entered", self, "back_entered")
	$Right.connect("body_entered", self, "right_entered")
	$Left.connect("body_entered", self, "left_entered")
	$Forward.connect("body_exited", self, "forward_exited")
	$Back.connect("body_exited", self, "back_exited")
	$Right.connect("body_exited", self, "right_exited")
	$Left.connect("body_exited", self, "left_exited")


func back_entered(body):
	if body.is_in_group("player"):
		dir = Vector3.FORWARD
		if not walls.forward:
			can_move = true
	else:
		walls.back = true
func back_exited(body):
	if body.is_in_group("player"):
		can_move = false
	else:
		walls.back = false
func forward_entered(body):
	if body.is_in_group("player"):
		dir = Vector3.BACK
		if not walls.back:
			can_move = true
	else:
		walls.forward = true
func forward_exited(body):
	if body.is_in_group("player"):
		can_move = false
	else:
		walls.forward = false


func right_entered(body):
	if body.is_in_group("player"):
		dir = Vector3.LEFT
		if not walls.left:
			can_move = true
	else:
		walls.right = true
func right_exited(body):
	if body.is_in_group("player"):
		can_move = false
	else:
		walls.right = false

func left_entered(body):
	if body.is_in_group("player"):
		dir = Vector3.RIGHT
		if not walls.right:
			can_move = true
	else:
		walls.left = true
func left_exited(body):
	if body.is_in_group("player"):
		can_move = false
	else:
		walls.left = false

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if can_move and not is_moving:
			var new = global_transform
			new.origin += dir * 8
			$Tween.interpolate_property(self,
					"global_transform",
					global_transform,
					new,
					1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			$Tween.start()
			is_moving = true
			yield($Tween,"tween_all_completed")
			is_moving = false
			get_tree().current_scene.HUD.add_push()
