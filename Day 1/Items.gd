extends Node2D

var item_name 
var item_quantity 

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		 item_name = "Alcohol Spray" 
	elif rand_val == 1: 
		item_name = "Face Shield"
	else: 
		item_name = "Vitamins"
	
	$TextureRect.texture = load("res://Day 1/Item_Icons/" + item_name + ".png")
	var stack_size = int(JsonData.item_data[item_name] ["StackSize"])
	item_quantity = randi() % stack_size + 1 
	
	if stack_size == 1: 
		$Label.visible = false
	else: 
		$label.text = String(item_quantity)

func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add 
	$Label.text = String(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$label.text = String(item_quantity)
		