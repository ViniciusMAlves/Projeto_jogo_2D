extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_anim_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()


@export var coins = 1
func _on_body_entered(body):
	$anim.play("collected")
	Global.coins += coins
	print(Global.coins)
