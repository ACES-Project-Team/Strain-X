extends Node2D


func _on_HSlider_value_changed(value):
	pass


func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	
	
func _on_TextureButton_pressed():
	get_tree().change_scene("res://Title Screen.tscn")
