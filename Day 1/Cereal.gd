extends Area2D

signal picked_up


func _on_Cereal_area_entered(area):
	emit_signal("picked_up")
	queue_free()

