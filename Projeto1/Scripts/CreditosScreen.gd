extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$btnReturn.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_return_pressed():
	get_tree().change_scene_to_file("res://Levels/start_screen.tscn")
