extends StaticBody2D

var is_touched := false 
func _ready():
	$MaskItemDrop.get("GetMask")
	
func interaction_can_interact(interactionParent: Node) -> bool:
	return interactionParent is Player
	
func interaction_get_text() -> String:
	return "GetMask"
	
func interaction_interact(interactionParent : Node) -> void:
	if is_touched:
		return
		
	$MaskItemDrop.get("GetMask")
	is_touched = true 
	

	 
	
