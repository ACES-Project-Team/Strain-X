extends Node2D

		
func _on_Resume_pressed():
	get_tree().change_scene("res://Day1.tscn")


func _on_Options_pressed():
	get_tree().change_scene("res://OptionsGame.tscn")


func _on_Quit_pressed():
	get_tree().quit()
	

