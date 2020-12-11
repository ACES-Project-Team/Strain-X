extends Camera2D

onready var tween = $Tween

var original_pos

signal player_camera

func _ready():
	original_pos = global_position

func move_to_position(target_pos : Vector2, speed : float):
	original_pos = global_position
	tween.interpolate_property(self, "global_position", original_pos, target_pos, (target_pos - original_pos).length() / speed)
	tween.start()
	yield(tween, "tween_all_completed")
	
	
func return_to_old_position(speed : float):
	tween.interpolate_property(self, "global_position", global_position, original_pos, (global_position - original_pos).length() / speed)
	tween.start()
	emit_signal("player_camera")
	yield(tween, "tween_all_completed")
	queue_free()
	
	

