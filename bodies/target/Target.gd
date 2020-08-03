extends Area

var has_crate = false
func _ready():
	connect("body_entered", self, "body_entered")
	connect("body_exited", self, "body_exited")

func body_entered(body):
	if body.is_in_group("crate"):
		has_crate = true
		$AnimationPlayer.play("up")

func body_exited(body):
	if body.is_in_group("crate"):
		has_crate = false
		$AnimationPlayer.play("down")
