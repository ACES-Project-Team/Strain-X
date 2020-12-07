extends CanvasLayer

onready var Pause = $Pause

func _input(event):
	if event.is_action_pressed("Pause"):
		Pause.visible = !Pause.visible
		
func _ready():
	pass # Replace with function body.

