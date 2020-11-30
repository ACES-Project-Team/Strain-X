extends Area2D

var enemy = null
var knockback_vec = Vector2.ZERO
export var damage = 0

func inrange():
	return enemy != null
	
func _on_Hitbox_body_entered(body):
	enemy = body

func _on_Hitbox_body_exited(body):
	enemy = null
