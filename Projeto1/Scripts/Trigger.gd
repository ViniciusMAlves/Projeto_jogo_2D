extends Area2D

signal PlayerEntered
@export var aviso: AudioStream

func _ready():
	
	$aviso.stream = aviso

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			emit_signal("PlayerEntered")
			$collision.queue_free()
			if aviso == null:
				queue_free()
			else:
				$aviso.play()
		


func _on_aviso_finished():
	queue_free()
