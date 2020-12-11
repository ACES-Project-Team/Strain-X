extends Node2D

onready var cam = $CutsceneCamera

func _ready():
	yield(cam.move_to_position(cam.global_position + Vector2.LEFT * 300, 50), "completed")
	yield(get_tree().create_timer(1.0), "timeout")
	yield(cam.return_to_old_position(500), "completed")
	
