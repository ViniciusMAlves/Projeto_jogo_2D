extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		Global.player_life -= 1
		Global.player_health = 3
		if Global.player_life < 1:
			get_tree().change_scene_to_file("res://prefabs/GameOver.tscn")
		else :
			get_tree().reload_current_scene()
