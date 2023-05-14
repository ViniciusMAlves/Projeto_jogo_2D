extends Area2D


func _on_body_entered(body):
	if body.has_method("Damage"):
		body.Damage()


func _on_start_timer_timeout():
	$anima.play("on")
	$FireCol.set_deferred("disabled", false)


func _on_stop_timer_timeout():
	$anima.play("off")
	$FireCol.set_deferred("disabled", true)
