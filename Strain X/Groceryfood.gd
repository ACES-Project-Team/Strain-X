extends Node2D

var count = 0

onready var foodcount = $YSort/Player/Count



func _on_Groceries_picked_up():
	count+=1
	foodcount.text = str(count)




func _on_Cereal_picked_up():
	count+=1
	foodcount.text = str(count)


func _on_CannedGoods_picked_up():
	count+=1
	foodcount.text = str(count)
