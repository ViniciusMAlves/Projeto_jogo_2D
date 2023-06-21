extends Area2D

@export var premio_instance: Array[PackedScene]

func create_premio():
	var premio_number = round(randf_range(0, premio_instance.size()-1))
	var premio = premio_instance[premio_number].instantiate()
	premio.global_position = $spawnPoint.global_position
	premio.apply_impulse(Vector2(randf_range(-30,30), -80), Vector2.ZERO)
	get_parent().call_deferred("add_child", premio)


func _on_body_entered(body):
	$anima.play("Open")


func _on_anima_animation_finished(anim_name):
	pass # Replace with function body.
