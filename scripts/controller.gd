extends Node2D
class_name GameController

onready var timer= $"../timer"
onready var player = $"../player"
onready var cloud_emitter = $"../cloud_emitter"
onready var pipe_emitter = $"../pipe_emitter"
onready var container = $"../spawn_container"
onready var gui = $"../CanvasLayer/gui"

var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
    game_started = false
    player.sleeping = true
    player.input_enabled = true
    cloud_emitter.emit()

func start_game() -> void:
    game_started = true
    pipe_emitter.emit()
    player.show_smoke()
    player.sleeping = false
    player.input_enabled = true
    gui.update_score(0)

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
    gui.show_retry_panel()

func _on_timer_timeout():
    player.input_enabled = true

func _on_player_player_jumped():
    if not game_started:
        start_game()
    timer.start()
    player.input_enabled = false

func _on_gui_retry_clicked():
    get_tree().reload_current_scene()
