extends Node

onready var cam = $Player/Camera2D

func _ready():
	yield(cam.move_to_position(cam.global_position + Vector2.LEFT * 100, 20), "completed")
	yield(get_tree().create_timer(2.0), "timeout")
	yield(cam.return_to_old_position(250), "completed")
	
