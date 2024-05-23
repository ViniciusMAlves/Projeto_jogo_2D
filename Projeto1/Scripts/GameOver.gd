extends CanvasLayer

func _ready():
	$Control/btnReturn.grab_focus()

func _on_btn_return_pressed():
	Global.checkpoint_pos = Vector2(0, 0)
	Global.player_life = 3
	get_tree().change_scene_to_file(Global.sena_atual)


func _on_btn_menu_pressed():
	get_tree().change_scene_to_file("res://Levels/start_screen.tscn")
