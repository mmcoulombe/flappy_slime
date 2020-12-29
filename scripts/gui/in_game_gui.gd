extends Control

signal retry_clicked()

onready var lbl_score = $"MarginContainer/score"
onready var lbl_fps = $"MarginContainer/fps"
onready var panel = $"retry_panel_container/panel"
onready var tween = $"Tween"
onready var btn_retry = $"retry_panel_container/panel/MarginContainer/VBoxContainer/btn_retry"

func _ready():
    panel.hide()

func _process(delta):
    lbl_fps.text = "FPS: " + str(Engine.get_frames_per_second())

func update_score(new_score):
    lbl_score.text = "Score: " + str(new_score)

func _on_TextureButton_pressed():
    emit_signal("retry_clicked")

func show_retry_panel() -> void:
    btn_retry.disabled = true
    panel.rect_scale = Vector2(0, 0)
    panel.visible = true
    tween.interpolate_property(panel, "rect_scale", Vector2(0, 0), Vector2(1, 1), 1, Tween.TRANS_ELASTIC)
    tween.start()
    yield(tween,"tween_completed")
    btn_retry.disabled = false
