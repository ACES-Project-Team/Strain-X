extends CanvasLayer 


func _ready():
	set_visible(false)

func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused

func _on_Resume_pressed():
	get_tree().paused = false 
	set_visible(false)
	
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible 

func _on_Options_pressed():
	get_tree().change_scene("res://OptionsGame.tscn")


func _on_Quit_pressed():
	get_tree().quit()
	

