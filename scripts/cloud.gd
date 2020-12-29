extends Node2D

export var speed = 200 setget set_speed, get_speed

func set_speed(value):
    speed = value

func get_speed():
    return speed

func _process(delta):
    position.x -= delta * speed


func _on_VisibilityNotifier2D_viewport_exited(viewport):
    queue_free()
