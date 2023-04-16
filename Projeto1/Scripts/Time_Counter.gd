extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_label()

func update_label():	
	var time = Time.get_ticks_msec() / 1000
	var minutes = int(time / 60)
	var seconds = int(time) % 60
	
	text = str("%02d" % minutes) + ":" + str("%02d" % seconds)	

