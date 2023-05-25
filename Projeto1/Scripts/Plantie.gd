extends CharacterBody2D

var facing_left = true

var hitted = false
var health = 3

@onready var  bullet_intance = preload("res://Scenes/seed.tscn")
@onready var player = Global.get("player")

@export var Bullet: PackedScene

func _physics_process(delta):
	_set_animation()
	
	if player:
		var distance = player.global_position.x - self.position.x
		facing_left = true if distance < 0 else false
		
	if facing_left:
		self.scale.x = 1
	else:
		self.scale.x = -1
		
func shoot():
	var bullet = bullet_intance.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $spawnShoot.global_position
	bullet.direction = 1 if facing_left else -1


func _on_player_detector_body_entered(body):
	$anima.play("attack")


func _on_player_detector_body_exited(body):
	$anima.play("Idle")


func _on_hitbox_body_entered(body):
	hitted = true
	health -= 1
	body.velocity.y = body.jump_force / 2
	await get_tree().create_timer(0.2).timeout
	hitted = false
	if health < 1:
		queue_free()
		get_node("hitbox/collision").set_deferred("disabled", true)
	
func _set_animation():
	var anim = "Idle"
	
	if player != null:
		if $playerDetector.overlaps_body(player):
			anim = "attack"
		elif velocity.x != 0:
			anim = "Idle"
	
	if  hitted:
		anim = "hit"
		
	if $anima.assigned_animation != anim:
		$anima.play(anim)
		
