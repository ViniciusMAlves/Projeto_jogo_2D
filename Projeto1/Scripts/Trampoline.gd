extends Area2D

@export var jumpForce = -720


func _on_body_entered(body):
	body.velocity.y = jumpForce
	$anima.play("jump")
