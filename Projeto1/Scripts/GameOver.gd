extends CanvasLayer

func _on_btn_return_pressed():
	Global.checkpoint_pos = Vector2(0, 0)
	get_tree().change_scene_to_file(Global.sena_atual)
