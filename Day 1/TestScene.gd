extends Node2D

var count = 000

onready var foodcount = $YSort/Player/Count



func _on_Groceries_picked_up():
	count+=1
	foodcount.text = str(count)
