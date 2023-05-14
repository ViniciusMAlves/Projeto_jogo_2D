extends Node2D

@onready var saw = $saw

@export var speed = 3.0
@export var horizontal = true
@export var distance = 192

var follow = Vector2.ZERO

const WAIT_DURATION = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_tween()

func _start_tween():
	var myTween = get_tree().create_tween().set_loops()
	
	var move_direction = Vector2.RIGHT * distance if horizontal else Vector2.UP * distance
	var duration = move_direction.length()/float(speed * 16)
	
	myTween.tween_property(self, "follow", move_direction, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT) 
	
	myTween.tween_property(self, "follow", Vector2.ZERO, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)


func _physics_process(delta):
	saw.position = saw.position.lerp(follow, 0.05)
