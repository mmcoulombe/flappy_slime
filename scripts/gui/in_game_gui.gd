extends Control

onready var lbl_score = get_node("MarginContainer/score")
onready var lbl_fps = get_node("MarginContainer/fps")
onready var anim_player = get_node("anim_player")

func _process(delta):
	lbl_fps.text = "FPS: " + str(Engine.get_frames_per_second())

func update_score(new_score):
	lbl_score.text = "Score: " + str(new_score)

func play_game_over():
	anim_player.play("game_over")