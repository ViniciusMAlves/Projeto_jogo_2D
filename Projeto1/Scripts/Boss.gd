extends enemyBase

signal BossDead

func _ready():
	set_physics_process(false)

func _process(delta):
	apply_gravity(delta)
	_set_boss_animation()


func _on_trigger_player_entered():	
	pass # Replace with function body.
	#set_physics_process(true)

func _set_boss_animation():
	var anim = "run"
	
	if $ray_wall.is_colliding():
		anim = "Idle"
	elif velocity.x != 0:
		anim = "run"
		if health < 3:
			speed = 100.0
	
	if  hitted:
		anim = "hit"
		
	if health < 1:
		anim = "die"
		emit_signal("BossDead")
	
	if $Anima.assigned_animation != anim:
		$Anima.play(anim)


func _on_arena_dorr_door_closed():
	set_physics_process(true)
	#pass # Replace with function body.
