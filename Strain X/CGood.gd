extends Area2D

func _ready():
	pass

func _on_CGood_area_entered(area):
	print(area.get_name())
