extends Area2D

@onready var changer = get_parent().get_node("Transition_in")

@export var path: String

func _on_body_entered(body):
	$anim.play("collected")


func _on_anim_animation_finished(anim_name):
	if anim_name == "collected":
		$sounds.play()


func _on_sounds_finished():
	changer.change_scene(path)
	
