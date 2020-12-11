extends CanvasLayer

signal transitioned

func _ready():
	transition()
	$MarginContainer/VBoxContainer/Continue.grab_focus()

func transition():
	$AnimationPlayer.play("fade_to_black")

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/Continue.is_hovered() == true:
			$MarginContainer/VBoxContainer/Continue.grab_focus()
	if $MarginContainer/VBoxContainer/Exit.is_hovered() == true:
			$MarginContainer/VBoxContainer/Exit.grab_focus()

func _on_Continue_pressed():
	get_tree().change_scene_to(load("res://Title Screen.tscn"))

func _on_Exit_pressed():
	get_tree().quit()
