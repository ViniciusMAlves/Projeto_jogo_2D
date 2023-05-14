extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$controls/btnStart.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_start_pressed():
	get_tree().change_scene_to_file("res://Levels/Level_01.tscn")


func _on_btn_controls_pressed():
	get_tree().change_scene_to_file("res://Levels/control_screen.tscn")


func _on_btn_quit_pressed():
	get_tree().quit()


func _on_btn_creditos_pressed():
	get_tree().change_scene_to_file("res://Levels/Creditos_screen.tscn")
