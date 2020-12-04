extends Node

func _ready():
	var rand = RandomNumberGenerator.new()
	var CGood_Scene= preload("res://CGood.tscn")
	
	var screen_size = get_viewport().get_visible_rect().size
	
	for i in range(0,5):
		var CGood = CGood_Scene.instance()
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, screen_size.y)
		CGood.position.y = y
		CGood.position.x = x 
		add_child(CGood)

		
