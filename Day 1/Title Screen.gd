extends Node

func _ready():
	$MarginContainer/VBoxContainer/NewGame.grab_focus()
	
func _physics_process(delta):
	if $MarginContainer/VBoxContainer/NewGame.is_hovered() == true:
			$MarginContainer/VBoxContainer/NewGame.grab_focus()
	if $MarginContainer/VBoxContainer/Options.is_hovered() == true:
			$MarginContainer/VBoxContainer/Options.grab_focus()
	if $MarginContainer/VBoxContainer/Exit.is_hovered() == true:
			$MarginContainer/VBoxContainer/Exit.grab_focus()
			
			


func _on_NewGame_pressed():
	get_tree().change_scene("res://Tutorial.tscn")

func _on_Exit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	get_tree().change_scene("res://Settings.tscn")
