extends Area2D

@export var Silabas = "" 
@export var Silabas_ant = "" 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_anim_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()


func _on_body_entered(body):
	if Global.silabas == Silabas_ant:
		$anim.play("collected")
		Global.silabas += Silabas
		print(Global.silabas)
