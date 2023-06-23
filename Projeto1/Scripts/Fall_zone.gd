extends Area2D

signal  reset_life()

# Called when the node enters the scene tree for the first time.
func _ready():
	var character_node = get_node("../HUB/HBoxContainer/Holder")
	var callable = Callable(character_node, "reset_life")
	connect("reset_life", callable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		print(Global.player_life)
		if Global.player_life < 1:
			get_tree().change_scene_to_file("res://prefabs/GameOver.tscn")
		else :
			Global.player_life -= 1
			Global.player_health = 3
			emit_signal("reset_life")
			body.position = Global.checkpoint_pos
