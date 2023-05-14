extends StaticBody2D

signal DoorClosed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trigger_player_entered():
	$anima.play("active")


func _on_boss_boss_dead():
	$anima.play("inactive")


func _on_anima_animation_finished(anim_name):
	if anim_name == "active":
		emit_signal("DoorClosed")
