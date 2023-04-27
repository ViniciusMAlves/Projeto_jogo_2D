extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var myTween = get_tree().create_tween().set_loops()
	
	myTween.tween_property($overlay, "progress", 0.0, 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
