extends enemyBase

func _ready():
	set_physics_process(false)

func _process(delta):
	apply_gravity(delta)
	_set_animation()


func _on_trigger_player_entered():
	set_physics_process(true)
