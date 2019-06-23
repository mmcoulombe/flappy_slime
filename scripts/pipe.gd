extends Node2D

signal score_updated(new_scare)

export(int) var space_between = 200 
export(int) var speed = 100 setget set_speed, get_speed

onready var top_pipe = $top_pipe
onready var bottom_pipe = $bottom_pipe

func set_speed(value):
	speed = value

func get_speed():
	return speed

# Called when the node enters the scene tree for the first time.
func _ready():
	var half_space = space_between * 0.5
	top_pipe.position.y -= half_space
	bottom_pipe.position.y += half_space

func _process(delta):
	position.x -= delta * speed

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

func _on_score_trigger_entered(body):
	body.score += 1
	emit_signal("score_updated", body.score)
