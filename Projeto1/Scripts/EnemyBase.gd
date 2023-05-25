extends CharacterBody2D
class_name enemyBase

@export var speed = 64.0
@export var health = 1
var move_direction = -1
var hitted = false
var delay = 0.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	velocity.x = move_direction * speed

	if move_direction == 1:
		$texture.flip_h = true
	else :
		$texture.flip_h = false
		
	_set_animation()
			
	move_and_slide()
	
	
func apply_gravity(delta):	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


func _on_anima_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "Idle":
		$ray_wall.scale.x *= -1
		move_direction *= -1
		$Anima.play("run")


func _on_hitbox_body_entered(body):
	hitted = true
	health -= 1
	body.velocity.y = body.jump_force / 2
	await get_tree().create_timer(0.2).timeout
	hitted = false
	if  health < 1:
		get_node("hitbox/Collision").set_deferred("disabled", true)
		set_physics_process(false)
		get_node("Collision").set_deferred("disabled", true)
		await get_tree().create_timer(delay).timeout
		queue_free()		
		
	
func _set_animation():
	var anim = "run"
	
	if $ray_wall.is_colliding():
		anim = "Idle"
	elif velocity.x != 0:
		anim = "run"
	
	if  hitted:
		anim = "hit"
		
	if $Anima.assigned_animation != anim:
		$Anima.play(anim)
