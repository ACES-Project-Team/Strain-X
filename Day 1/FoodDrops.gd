extends Area2D

signal picked_up

func _on_Groceries_area_entered(area):
	emit_signal("picked_up")
	queue_free()

func _on_FoodDrops_picked_up():
	count+=1
	foodcount.text = str(count)
