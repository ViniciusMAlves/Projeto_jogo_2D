extends CharacterBody2D

#var velocity = Vector2.ZERO
var move_speed = 480
var gravity = 1200
var jump_force = -720
var is_grounded
@onready var raycasts = $raycasts

func _physics_process(delta):	
	velocity.y += gravity * delta	
	
	_get_input()
	
	set_velocity(velocity)
	move_and_slide()
	velocity =  velocity
	
	is_grounded = _check_is_ground()
	
	_set_animation()

func _get_input():
	velocity.x = 0
	var move_direction = float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left"))	
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction != 0:
		$texture.scale.x = move_direction

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force / 2	
		

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false

func _set_animation():
	var anim = "Idle"
	
	if !is_grounded:
		anim = "jump"
	elif velocity.x != 0:
		anim = "run"
		
	if $anime.assigned_animation != anim:
		$anime.play(anim)
