extends Node2D

func _on_Button_pressed():
	$Inventory.visible = !$Inventory.visible


func _on_TextureButton_pressed():
	$Inventory.visible = !$Inventory.visible
