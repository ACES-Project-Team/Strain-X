extends Node2D

signal change_to_alcohol_attack


func _on_GroceryOutfit_tree_entered():
	emit_signal("change_to_alcohol_attack")
