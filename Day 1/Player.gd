extends KinematicBody2D

enum { 
	STOP, 
	MOVE, 
	ATTACK }

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var FRICTION = 500
var state = MOVE

export var hasSprayBottle = false

const Alcohol_Spray_texture = preload("res://Day 1/Item_Icons/Alcohol Spray.png")
const Uv_LightSaber_texture = preload("res://Day 1/Item_Icons/Uv LightSaber.png")
const Surgical_Mask_texture = preload("res://Day 1/Item_Icons/Surgical Mask.png")
const Face_Shield_texture = preload("res://Day 1/Item_Icons/Face Shield.png")

onready var on_hand_sprite = $Sprites/OnHandSprite 

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

onready var hurtbox = $Hurtbox

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		STOP:
			pass
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) 
		
	velocity = move_and_slide(velocity)
	
	if hasSprayBottle:
		if Input.is_action_pressed("attack"):
			state = ATTACK
		
func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE

func _input(event):
	if event.is_action_pressed("PickUp"):
		if $PickUpZone.items_in_range.size() > 0: 
			var pickup_item = $PickUpZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickUpZone.items_in_range.erase(pickup_item)
	
	velocity = move_and_slide(velocity)

func play_walk_in_animation():
		state = STOP
		$AnimationPlayer.play("RunUp")
		
		
func _unhandled_input(event):
	if event.is_action_pressed("change_to_spray"):
		on_hand_sprite.texture = Alcohol_Spray_texture
	elif event.is_action_pressed("change_to_lightsaber"):
		on_hand_sprite.texture = Uv_LightSaber_texture

func _on_Timer_timeout():
		self.invincible = false 


func _on_Hurtbox_invincibility_started():
	collisionshape.set_deferred("disabled",true)
	set_deferred("Monitorable",false)


func _on_Hurtbox_invincibility_ended():
	collisionshape.disabled = false
	monitorable = true
