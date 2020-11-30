extends KinematicBody2D

enum State { STOP, MOVE }

const ACCELERATION =500	
const MAX_SPEED = 80
const FRICTION = 500
var state = State.MOVE

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) 
		
	velocity = move_and_slide(velocity)
	
func _input(event):
	if event.is_action_pressed("PickUp"):
		if $PickUpZone.items_in_range.size() > 0: 
			var pickup_item = $PickUpZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickUpZone.items_in_range.erase(pickup_item)
	
	velocity = move_and_slide(velocity)

func play_walk_in_animation():
		state = State.STOP
		$AnimationPlayer.play("RunUp")
