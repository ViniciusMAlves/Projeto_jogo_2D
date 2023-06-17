extends Area2D

@export var stream: AudioStream


# Called when the node enters the scene tree for the first time.
func _ready():
	$narrador.stream = stream



func _on_body_entered(body):
	if body.name == "Player":
		$narrador.play()
		$collision.queue_free()
