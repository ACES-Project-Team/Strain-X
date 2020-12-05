extends Node2D

var item_name 
var item_quantity 

func _ready():
	var rand_val = randi() % 7
	if rand_val == 0:
		 item_name = "Alcohol Spray" 
	elif rand_val == 1: 
		item_name = "Face Shield"
	elif rand_val == 2: 
		item_name = "Vitamins"
	elif rand_val == 3: 
		item_name = "Surgical Mask"
	elif rand_val == 4: 
		item_name = "Uv LightSaber"
	elif rand_val == 5: 
		item_name = "Cloth Mask"
	elif rand_val == 6: 
		item_name = "Canned Goods"
	elif rand_val == 7: 
		item_name = "Cherry"
	
	$TextureRect.texture = load("res://Assets/Item_Icons/" + item_name + ".png")
	var stack_size = int(JsonData.item_data[item_name] ["StackSize"])
	item_quantity = randi() % stack_size + 1 
	
	if stack_size == 1: 
		$Label.visible = false
	else: 
		$Label.text = String(item_quantity)


func set_item(nm, qt):
	item_name = nm 
	item_quantity = qt
	$TextureRect.texture = load("res://Assets/Item_Icons/" + item_name + ".png")
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1: 
		$Label.visible = false 
	else: 
		$Label.visible = true
		$Label.text = String(item_quantity)
		
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add 
	$Label.text = String(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)
		
