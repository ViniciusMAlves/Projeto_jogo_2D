extends Area2D

@onready var changer = get_parent().get_node("Transition_in")

@export var path: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		$confete.emitting = true
		changer.change_scene(path)
		Global.checkpoint_pos = Vector2(128, 16)
