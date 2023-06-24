extends Area2D


func _on_anim_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()


@export var coins = 1
func _on_body_entered(body):
	$anim.play("collected")
	Global.coins += coins
