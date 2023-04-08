extends CharacterBody2D

@onready var anim = $anim
@onready var timer = $timer

@onready var reset_position = global_position 

var is_triggered = false
@export var reset_timer = 3.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	set_physics_process(false)

func  _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta

func collide_with(collision: KinematicCollision2D, cllider: CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		anim.play("shake")
		velocity = Vector2.ZERO


func _on_anim_animation_finished(anim_name):
	set_physics_process(true)
	timer.start(reset_timer)


func _on_timer_timeout():
	set_physics_process(false)
	await get_tree().physics_frame
	var temp = collision_layer
	collision_layer = 0
	global_position = reset_position
	await  get_tree().physics_frame
	collision_layer = temp
	is_triggered = false
