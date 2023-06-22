extends CharacterBody2D

#var velocity = Vector2.ZERO
var move_speed = 480
var gravity = 1200
var jump_force = -720
var is_grounded

var player_health = 3
var max_health = 3
var player_life = 3

var hurted = false

var knockback_dir = 1
var knockback_int = 800

var is_pushing = false

@onready var raycasts = $raycasts

signal  chage_life(player_health)
signal  reset_life()


func _ready():
	Global.set("player", self)
	var character_node = get_node("../HUB/HBoxContainer/Holder")
	var callable = Callable(character_node, "on_change_life")
	var callable_reset = Callable(character_node, "reset_life")
	connect("chage_life", callable)
	connect("reset_life", callable_reset)
	emit_signal("chage_life", max_health)
	emit_signal("reset_life")
	position = Global.checkpoint_pos
	

func _physics_process(delta):	
	velocity.y += gravity * delta	
	velocity.x = 0
	
	if !hurted:
		_get_input()
		
	MoveBox(delta)
	
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
		
	if velocity.x > 1:
		$pushRight.set_enabled(true)
	else:
		$pushRight.set_enabled(false)
	if velocity.x < -1:
		$pushLeft.set_enabled(true)
	else:
		$pushLeft.set_enabled(false)

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
	elif velocity.x != 0 or is_pushing:
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
	Damage()
		
func hit_checkpoint():
	Global.checkpoint_pos = position


func _on_head_collider_body_entered(body):
	if body.has_method("destroy"):
		body.destroy()


func _on_hurtbox_area_entered(area):
	Damage()
		
func Damage():
	player_health -= 1
	Global.player_health -= 1
	hurted = true
	emit_signal("chage_life", Global.player_health)
	knockback()
	get_node("Hurtbox/Collision").set_deferred("disabled", true)
	await get_tree().create_timer(0.5).timeout
	get_node("Hurtbox/Collision").set_deferred("disabled", false)
	hurted = false
	GameOver()
	
		
func MoveBox(delta):
	var object
	is_pushing = false
	if $pushRight.is_colliding():
		object = $pushRight.get_collider()
		object.set_velocity(Vector2(10,0) * move_speed * delta)
		object.move_and_slide()
		is_pushing = true
	elif $pushLeft.is_colliding():
		object = $pushLeft.get_collider()
		object.set_velocity(Vector2(-10,0) * move_speed * delta)
		object.move_and_slide()
		is_pushing = true
		
func GameOver():
	print(Global.player_life)
	if Global.player_health < 0:
		Global.is_dead = true
		Global.player_life -= 1
		Global.player_health = 3
		emit_signal("reset_life")
		
		position = Global.checkpoint_pos
		
	if  Global.player_life < 0:
		get_tree().change_scene_to_file("res://prefabs/GameOver.tscn")
	
