extends Node

var checkpoint_pos = Vector2(0, 0)
@export var path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.sena_atual = path
	Global.coins = 0
	Global.silabas = ""
	if Global.is_dead:
		Global.player_health = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
