extends CharacterBody2D

#var velocity = Vector2.ZERO
var move_speed = 480
var gravity = 1200
var jump_force = -720
var is_grounded

var player_health = 3
var max_health = 3

var hurted = false

var knockback_dir = 1
var knockback_int = 500

@onready var raycasts = $raycasts

signal  chage_life(player_health)


func _ready():
	var character_node = get_node("../HUB/HBoxContainer/Holder")
	var callable = Callable(character_node, "on_change_life")
	connect("chage_life", callable)
	emit_signal("chage_life", max_health)
	position = Global.checkpoint_pos

func _physics_process(delta):	
	velocity.y += gravity * delta	
	velocity.x = 0
	
	if !hurted:
		_get_input()
	
	set_velocity(velocity)
	move_and_slide()
	velocity =  velocity
	
	is_grounded = _check_is_ground()
	
	_set_animation()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("collide_with"):
			collision.get_collider().collide_with(collision, self)

func _get_input():
	velocity.x = 0
	var move_direction = float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left"))	
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction != 0:
		$texture.scale.x = move_direction
		knockback_dir = move_direction

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
	
	if velocity.y > 0 and !is_grounded:
		anim = "fall"
	
	if  hurted:
		anim = "hit"
		
	if $anime.assigned_animation != anim:
		$anime.play(anim)

func knockback():
	if $right.is_colliding():
		velocity.x = -knockback_dir * knockback_int
	
	if $left.is_colliding():
		velocity.x = knockback_dir * knockback_int
	
	move_and_slide()

func _on_hurtbox_body_entered(body):
	player_health -= 1
	hurted = true
	emit_signal("chage_life", player_health)
	knockback()
	get_node("Hurtbox/Collision").set_deferred("disabled", true)
	await get_tree().create_timer(0.5).timeout
	get_node("Hurtbox/Collision").set_deferred("disabled", false)
	hurted = false
	
	if player_health < 1:
		queue_free()
		get_tree().reload_current_scene()
		
func hit_checkpoint():
	Global.checkpoint_pos = position
