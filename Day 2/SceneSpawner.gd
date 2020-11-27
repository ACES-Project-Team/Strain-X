extends Node


func _ready():
	var rand = RandomNumberGenerator.new()
	var enemyspawn = load("res://Volatiles.tscn")
	
	var screen_size = get_viewport().get_visible_rect().size
	
	for i in range(0,10):
		var Volatiles = enemyspawn.instance() 
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0,screen_size.y)
		Volatiles.position.y = y
		Volatiles.position.x = x
		add_child(Volatiles)




