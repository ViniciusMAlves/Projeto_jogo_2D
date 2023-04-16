extends Label

var seconds = 0
var min = 0
# Called when the node enters the scene tree for the first time.
func _process(delta):
	text = str("%04d" % Global.coins)
	
