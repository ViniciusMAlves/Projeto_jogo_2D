extends Control

@onready var Heart1 = $heart_1
@onready var Heart2 = $heart_2
@onready var Heart3 = $heart_3

var life_size = 32

# Called when the node enters the scene tree for the first time.
func on_change_life(player_healph):
	if player_healph == 2:
		if Heart3 != null:
			Heart3.queue_free()
	
	if player_healph == 1:
		if Heart2 != null:
			Heart2.queue_free()
	
	if player_healph == 0:
		if Heart1 != null:
			Heart1.queue_free()
			
	#$lifes.rect_size.x = player_healph * life_size


