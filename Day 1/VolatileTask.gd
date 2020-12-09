extends Area2D

var can_interact = false

func _ready():
	pass



func _input(event):
	if Input.is_action_just_pressed("PickUp") and can_interact == true: 
		$Label.text = "Kill Volatiles" 



func _on_VolatileTask_body_exited(body):
		if body.name == "ClothMaskOutfit":
			$Label.hide()
			can_interact = false 
			$Label.text = "Interact (E)"

func _on_VolatileTask_body_entered(body):
	if body.name == "ClothMaskOutfit":
		$Label.show()
		can_interact = true

