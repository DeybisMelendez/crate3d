extends Spatial
var Wall = preload("res://bodies/wall/Wall.tscn")
var Floor = preload("res://bodies/floor/Floor.tscn")
var Crate = preload("res://bodies/crate/Crate.tscn")
var Player = preload("res://bodies/player/Player.tscn")
var Target = preload("res://bodies/target/Target.tscn")
var win = false
onready var HUD = $HUD

func _ready():
	var level = load_level(Global.level.path)
	var pos = Vector3.ZERO
	var push = ""
	for c in level:
		pos.x +=1
		match c:
			"#":
				instance_node(Wall, pos)
			"@":
				instance_node(Player, pos)
				instance_node(Floor, pos)
			" ":
				instance_node(Floor, pos)
			"$":
				instance_node(Crate, pos)
				instance_node(Floor, pos)
			"*":
				instance_node(Crate, pos)
				instance_node(Floor, pos)
				instance_node(Target, pos)
			".":
				instance_node(Floor, pos)
				instance_node(Target, pos)
			"\n":
				pos.z += 1
				pos.x = 0
			"0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
				push += c
	HUD.total_push = int(push)
	HUD.update_push()

func load_level(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var content = file.get_as_text()
		file.close()
		return content
	file.close()

func instance_node(node, pos):
	var this = node.instance()
	this.transform.origin = pos*8
	add_child(this)

func _physics_process(delta):
	var targets = get_tree().get_nodes_in_group("target")
	if not win:
		var check_target = true
		for target in targets:
			if not target.has_crate:
				check_target = false
		if check_target:
			HUD.show_WinMenu()
			win = true
