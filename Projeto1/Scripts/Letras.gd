extends Area2D

@export var letra = "" 
@export var letra_ant = "" 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Letras_body_entered(body):
	if Global.silabas == letra_ant:
		$Anima.play("collected")
		Global.silabas += letra
		print(Global.silabas)


func _on_anima_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()
