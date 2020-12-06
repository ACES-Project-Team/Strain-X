extends KinematicBody2D

var knockback =  Vector2.ZERO
var vel = Vector2.ZERO
var state = idle

export var acceleration = 300
export var max_speed = 80
export var friction = 200
export var wander_range = 4

enum{
	idle,
	wander,
	chase
}

onready var sprite = $Sprite
onready var wandercontroller = $WanderController
onready var animationplayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO,friction*delta)
	knockback = move_and_slide(knockback)
	vel = move_and_slide(vel)
	match state:
		idle:
			vel = vel.move_toward(Vector2.ZERO,friction*delta)
			animationstate.travel("Idle")
			if wandercontroller.get_time_left()==0:
				state_randomizer()
		wander:

			if wandercontroller.get_time_left() == 0:
				state_randomizer()
			move_to_point(wandercontroller.target_position,delta)
			animationstate.travel("Walk")
			if global_position.distance_to(wandercontroller.target_position) <= wander_range:
				state_randomizer()

func state_randomizer():
	state = random_new_state([idle, wander])
	wandercontroller.start_wander_timer(rand_range(1,3))

func move_to_point(point,delta):
	var location = global_position.direction_to(point)
	vel = vel.move_toward(location*max_speed,acceleration*delta)
	sprite.flip_h = vel.x < 0

func random_new_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
