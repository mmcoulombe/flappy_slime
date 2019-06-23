extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const Pipe = preload("res://prefabs/pipe.tscn")

export(int) var speed = 100
export(float) var delay = 3
export(int) var spawn_padding = 25

onready var controller = get_node("../controller")
onready var container = get_node("../spawn_container")
onready var timer = $pe_timer

var is_emitting = false

func _ready():
	timer.stop()
	timer.wait_time = delay

func emit():
	is_emitting = true
	timer.start()

func is_stopped():
	return not is_emitting 

func stop():
	timer.stop()
	is_emitting = false

func restart():
	is_emitting = true
	timer.start()

func spawn():
	var pipe = Pipe.instance()
	container.add_child(pipe)

	pipe.z_index = 1
	pipe.global_position = global_position
	pipe.speed = speed
	pipe.connect("score_updated", controller, "_on_player_score_updated")
	
	give_random_height(pipe)

func give_random_height(pipe):
	var screen_size = get_viewport().size
	var half_space = pipe.space_between * 0.5
	var center = screen_size.y * 0.5
	
	# calculate the y axes range for the pipe
	var spawn_range = center - half_space - spawn_padding
	var min_y = center - spawn_range
	var max_y = center + spawn_range

	var y = rand_range(min_y, max_y)
	pipe.global_position.y = y

func _on_pe_timer_timeout():
	spawn()
