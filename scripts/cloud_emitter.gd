extends Node2D


const Cloud = preload("res://prefabs/cloud.tscn")

export(int) var min_spawn_delay = 2
export(int) var max_spawn_delay = 5

export(float) var min_speed = 100
export(float) var max_speed = 300

export(int) var min_height = 200
export(int) var max_height = -400

onready var container = get_node("../spawn_container")
onready var timer = $ce_timer

var is_emitting = false
var elems = []

func _ready():
	timer.stop()
	timer.wait_time = rand_range(min_spawn_delay, max_spawn_delay)

func emit():
	is_emitting = true
	timer.start();
	
func spawn_cloud():
	var cloud = Cloud.instance()
	container.add_child(cloud)

	cloud.z_index = 0
	cloud.global_position = global_position
	cloud.speed = rand_range(min_speed, max_speed)
	cloud.position.y += rand_range(min_height, max_height)	

func is_stopped():
	return not is_emitting 

func stop():
	timer.stop()
	is_emitting = false

func restart():
	is_emitting = true
	timer.start()

func _on_ce_timer_timeout():
	spawn_cloud()
	timer.wait_time = rand_range(min_spawn_delay, max_spawn_delay)
