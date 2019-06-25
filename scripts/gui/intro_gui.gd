extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var btn_start = $btn_start

func _on_start_button_pressed():
	get_tree().change_scene("res://scenes/main.tscn")


func _on_button_start_down():
	print("down")
	btn_start.scale = Vector2(0.8, 0.8)

func _on_button_start_up():
	btn_start.scale = Vector2(1, 1)
