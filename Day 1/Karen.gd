extends KinematicBody2D

var knockback =  Vector2.ZERO
var vel = Vector2.ZERO
var damage = Hitbox
var state = Idle

export var acceleration = 300
export var max_speed = 80
export var friction = 200
export var wander_range = 4

enum{
	Idle,
	wander,
	chase,
	Attack
}

onready var volsprite = $Sprite
onready var volAnimationPlayer = $AnimationPlayer
onready var volAnimationTree = $AnimationTree
onready var volHurtbox = $Hurtbox
onready var detectionzone = $DetectionZone
onready var wandercontroller = $WanderController
onready var volStats = $Stats
onready var volanimationstate = volAnimationTree.get("parameters/playback")
onready var hitbox = $Hitbox

func _ready():
	volAnimationTree.active = true
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO,friction*delta)
	knockback = move_and_slide(knockback)
	
	vel = move_and_slide(vel)
	match state:
		Idle:
			vel = vel.move_toward(Vector2.ZERO,friction*delta)
			seek_player()
			volanimationstate.travel("Idle")
			if wandercontroller.get_time_left()==0:
				state_randomizer()
		wander:
			seek_player()
			
			if wandercontroller.get_time_left() == 0:
				state_randomizer()
			move_to_point(wandercontroller.target_position,delta)
			
			volanimationstate.travel("Walk")
			
			if global_position.distance_to(wandercontroller.target_position) <= wander_range:
				state_randomizer()
				
		chase:
			var player = detectionzone.player
			if player != null:
				volanimationstate.travel("Walk")
				move_to_point(player.global_position,delta)
			else:
				state = Idle
				
		Attack:
			var player = hitbox.enemy
			if player != null:
				volanimationstate.travel("Attack")
			else:
				state = Idle
	
func state_randomizer():
	state = random_new_state([Idle, wander])
	wandercontroller.start_wander_timer(rand_range(1,3))
	
func move_to_point(point,delta):
	var location = global_position.direction_to(point)
	vel = vel.move_toward(location*max_speed,acceleration*delta)
	volsprite.flip_h = vel.x < 0
	
func seek_player():
	if detectionzone.can_see_enemy():
		state = chase

func random_new_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Stats_no_health():
	volanimationstate.travel("Walk")
	queue_free()

func _on_Hurtbox_area_entered(area):
	volStats.HEALTH -= area.damage
	knockback = area.knockback_vec * 120
	volHurtbox.start_invincibility(.4)
	print(volStats.HEALTH)

func _on_Hitbox_area_entered(area):
	volanimationstate.travel("Attack")
	state = Attack
