extends Node2D

onready var anim_player = get_node("AnimationPlayer")

func show():
	anim_player.play("show")
	yield(anim_player, "animation_finished")
	anim_player.play("flash")

func hide():
	anim_player.play_backwards("show")
	queue_free()
