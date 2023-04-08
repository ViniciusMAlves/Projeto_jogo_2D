extends CharacterBody2D

const SPEED = 64.0
var health = 1
var move_direction = -1
var hitted = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	velocity.x = move_direction * SPEED
	velocity.y += gravity * delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if move_direction == 1:
		$texture.flip_h = true
	else :
		$texture.flip_h = false
		
	_set_animation()
			
	move_and_slide()

	


func _on_anima_animation_finished(anim_name):
	if anim_name == "Idle":
		$ray_wall.scale.x *= -1
		move_direction *= -1
		$Anima.play("run")


func _on_hitbox_body_entered(body):
	hitted = true
	health -= 1
	body.velocity.y -= 300
	await get_tree().create_timer(0.2).timeout
	hitted = false
	
func _set_animation():
	var anim = "run"
	
	if $ray_wall.is_colliding():
		anim = "Idle"
	elif velocity.x != 0:
		anim = "run"
	
	if  hitted:
		anim = "hit"
		
	if  health < 1:
		queue_free()
		get_node("hitbox/Collision").set_deferred("disabled", true)
		
	if $Anima.assigned_animation != anim:
		$Anima.play(anim)
