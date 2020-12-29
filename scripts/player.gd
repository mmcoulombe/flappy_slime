extends RigidBody2D

signal player_death(player)
signal player_jumped()

export(int) var flap_force = 200

onready var player_sprite = $body
onready var collision_shape = $collision_shape
onready var anim_player = $AnimationPlayer
onready var tween = $Tween
onready var smoke = $smoke

var score = 0 setget set_score, get_score

var velocity = Vector2()
var input_enabled = true
var is_alive = true

func set_score(value):
    score = value

func get_score():
    return score

func apply_input(delta):
    if input_enabled:
        var flap = Input.is_action_just_pressed("jump")
        if flap:
            _jump(delta)

func show_smoke() -> void:
    smoke.emitting = true

func hide_smoke() -> void:
    smoke.emitting = false

func _ready():
    is_alive = true
    hide_smoke()

func _animate_flap()-> void:
    input_enabled = false
    var current_rot = rotation_degrees
    tween.interpolate_property(player_sprite, "rotation_degrees", current_rot, -15, 0.2, Tween.TRANS_LINEAR)
    tween.start()
    yield(tween, "tween_completed")
    input_enabled = true
    tween.interpolate_property(player_sprite, "rotation_degrees", -15, 15, 0.3, Tween.TRANS_LINEAR)
    tween.start()

func _jump(delta) -> void:
    linear_velocity = Vector2(0, -1) * flap_force
    _animate_flap()
    emit_signal("player_jumped")

func _physics_process(delta):
    apply_input(delta)

func play_death_choreograhpy():
    input_enabled = false
    collision_shape.disabled = true
    anim_player.play("explosion")

func die():
    if is_alive:
        is_alive = false
        emit_signal("player_death", self)	

func _on_player_screen_exited():
    die()

func _on_player_body_entered(body):
    if is_alive:
        call_deferred("die")
