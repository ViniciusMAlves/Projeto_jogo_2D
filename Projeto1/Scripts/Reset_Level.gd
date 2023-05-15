extends Node

var checkpoint_pos = Vector2(128, 16)
@export var path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.coins = 0
	Global.silabas = ""
	if Global.is_dead:
		Global.player_health = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
