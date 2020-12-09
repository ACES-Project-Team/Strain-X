extends Area2D

var can_interact = false
func _ready():
	pass


func _input(event):
	if Input.is_action_just_pressed("PickUp") and can_interact == true: 
		$Label.text = "Avoid Karens" 


func _on_Area2D2_body_exited(body):
	if body.name == "GroceryOutfit ":
		$Label.hide()
		can_interact = false 
		$Label.text = "Interact (E)"


func _on_Area2D2_body_entered(body):
	if body.name == "GroceryOutfit ":
		$Label.show()
		can_interact = true
