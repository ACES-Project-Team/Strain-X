extends Node

var score = 0

onready var CGood_Container = get_node("CGood_Container")

func _ready():
	set_process(true)
	spawn_cgood()
	
func spawn_cgood():
	for i in range(0,5):
		var CGood_Scene= preload("res://CGood.tscn")
		var CGood = CGood_Scene.instance()
		CGood_Container.add_child(CGood)
		var rand = RandomNumberGenerator.new()
		var screen_size = get_viewport().get_visible_rect().size
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, screen_size.y)
		CGood.position.y = y
		CGood.position.x = x 
		add_child(CGood)

		
