extends Area2D

var can_interact = false

func _ready():
	pass 
		
func _input(event):
	if Input.is_action_just_pressed("PickUp") and can_interact == true: 
		$Label.text = "Go to the Safe Place"
		

func _on_Task3_body_entered(body):
	if body.name == "Player":
		$Label.show()
		can_interact = true
	


func _on_Task3_body_exited(body):
	if body.name == "Player":
		$Label.hide()
		can_interact = false 
		$Label.text = "Interact (E)"
