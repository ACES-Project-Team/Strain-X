extends Node2D


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_HSlider2_value_changed(value):
	pass # Replace with function body.
