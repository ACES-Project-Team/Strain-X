extends KinematicBody2D

const DeathEffect = preload("res://DeathEffect.tscn")
export var ACCELERATION = 300 
export var MAX_SPEED = 50
export var FRICTION = 200
enum {
	IDLE,
	WANDER,
	CHASE
}
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO 

var state = CHASE 

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var detectionzone = $DetectionZone

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		
		WANDER:
			pass
		
		CHASE:
			var player = detectionzone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
 
	velocity = move_and_slide(velocity)

func seek_player():
	if detectionzone.can_see_enemy():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	stats.HEALTH -= area.damage
#	knockback = area.knockback_vector * 120


func _on_Stats_no_health():
	queue_free()
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position
