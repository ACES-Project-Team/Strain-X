extends KinematicBody2D
const DeathEffect = preload ("res://DeathEffect.tscn")
signal change_to_alcohol_attack

enum { 
	STOP, 
	MOVE, 
	ATTACK }

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var FRICTION = 500
var state = MOVE
var attack1 = swtich_attack()
var stats = PlayerStats
var velocity = Vector2.ZERO

export var hasLightsaber = false

#onready var on_hand_sprite = $Sprites/OnHandSprite 
onready var animationPlayer = $AnimationPlayer 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hitbox = $Hitbox_pivot/Hitbox
onready var hurtbox = $Hurtbox

func _ready():
	stats.connect("no_health", self, "queue_free")
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
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) 
		
	velocity = move_and_slide(velocity)
	
	if hasLightsaber:
		if Input.is_action_pressed("attack"):
			$SwooshSound.play()
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


func _on_Hurtbox_invincibility_started():
	pass


func _on_Hurtbox_invincibility_ended():
	pass


func _on_Hurtbox_area_entered(area):
	stats.HEALTH -= area.damage
	hurtbox.start_invincibility(.5)

func swtich_attack():
	if Input.is_action_pressed("change_to_spray"):
		if attack1 == true:
			emit_signal("change_to_alcohol_attack") 


func _on_CutsceneCamera_player_camera():
	var cam = Camera2D.new()
	add_child(cam)
	cam.current = true


func _on_PlayerStats_no_health():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position
