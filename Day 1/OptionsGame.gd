extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_TextureButton_pressed():
	get_tree().change_scene("res://Day1.tscn")


func _on_HSlider_value_changed(value):
	pass # Replace with function body.


func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)