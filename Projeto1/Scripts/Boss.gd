extends enemyBase

signal BossDead

var life_size = 7
var lifeBar_size = 2

func _ready():
	set_physics_process(false)
	delay = 0.7
	$bar.set_size(Vector2((lifeBar_size * health)+2,(lifeBar_size+2)))
	$bar.position.y = $bar.position.y - 1
	$bar.position.x = -1*(((lifeBar_size * health)+2)/2)
	
	$lifebar.set_size(Vector2(lifeBar_size * health,(lifeBar_size)))
	$lifebar.position.x = -1*((lifeBar_size * health)/2)
	
	
	$lifes.set_size(Vector2(life_size * health,0))
	$lifes.position.x = -1*((life_size * health)/2)

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
		if health <= 3:
			anim = "AngryRun"
			speed = 100.0
	
	if  hitted:
		anim = "hit"
		$lifebar.set_size(Vector2(lifeBar_size * health,(lifeBar_size)))
		$lifes.set_size(Vector2(life_size * health,0))
		$lifes.position.x = -1*((life_size * health)/2)
		
	if health < 1:
		anim = "die"
		emit_signal("BossDead")
	
	if $Anima.assigned_animation != anim:
		$Anima.play(anim)


func _on_arena_dorr_door_closed():
	set_physics_process(true)
	#pass # Replace with function body.
