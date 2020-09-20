extends Node2D

onready var timer = get_node("../timer")
onready var key_animation = get_node("../key_animation")
onready var player = get_node("../player")
onready var cloud_emitter = get_node("../cloud_emitter")
onready var pipe_emitter = get_node("../pipe_emitter")
onready var container = get_node("../spawn_container")
onready var black_rect = get_node("../black_rect")
onready var gui = get_node("../ui/gui")

# Called when the node enters the scene tree for the first time.
func _ready():
	cloud_emitter.emit()
	pipe_emitter.emit()
	key_animation.show()
	player.sleeping = true
	player.input_enabled = false
	yield(get_tree().create_timer(2.5), "timeout")
	player.sleeping = false
	player.input_enabled = true
	key_animation.hide()

func freeze_paralax():
	cloud_emitter.stop()
	pipe_emitter.stop()

	for n in container.get_children():
		if n.has_method('set_speed'):
			n.set_speed(0)

func _on_player_score_updated(new_score):
	gui.update_score(new_score)

func _on_player_death(player):
	freeze_paralax()
	player.play_death_choreograhpy()
	black_rect.visible = true
	gui.play_game_over()

func _on_timer_timeout():
	player.input_enabled = true


func _on_player_player_jumped():
	timer.start()
	player.input_enabled = false
