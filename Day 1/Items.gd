extends Node2D

func _ready():
	if randi() % 2 == 0: 
		$TextureRect.texture = load("res://Day 1/UI/alcohol spray bottle-Sheet.png") 
	else: 
		$TextureRect.texture = load("res://Day 1/UI/face shield-Sheet.png") 

