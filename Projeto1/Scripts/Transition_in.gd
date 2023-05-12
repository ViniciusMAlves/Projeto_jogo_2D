extends CanvasLayer


func change_scene(path, delay = 2.5):
	var myTween = get_tree().create_tween().set_loops()
	
	myTween.tween_property($overlay, "progress", 1.0, 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
	
	await get_tree().create_timer(2.0).timeout
	assert(get_tree().change_scene_to_file(path) == OK)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
