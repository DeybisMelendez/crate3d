extends Spatial
var Wall = preload("res://bodies/wall/Wall.tscn")
var Floor = preload("res://bodies/floor/Floor.tscn")
var Crate = preload("res://bodies/crate/Crate.tscn")
var Player = preload("res://bodies/player/Player.tscn")
var Target = preload("res://bodies/target/Target.tscn")

func _ready():
	var level_name = Global.level.world + " " + Global.level.name
	$Control/HBoxContainer/Label2.text = level_name
	var level = load_level(Global.level.path)
	var pos = Vector3.ZERO
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

#func _ready():
#	init("Minicosmos 1", "res://scenes/levels/minicosmos/1.txt")

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
