extends KinematicBody2D

signal player_death(player)

export(int) var gravity = 980
export (int) var flap_speed = -400

onready var collision_shape = $collision_shape
onready var anim_player = $AnimationPlayer

var score = 0 setget set_score, get_score
var velocity = Vector2()
var input_enabled = true
var is_alive = true

func set_score(value):
	score = value

func get_score():
	return score

func apply_input():
	if input_enabled:
		var flap = Input.is_action_just_pressed("ui_up")
		if flap:
			velocity.y = flap_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	is_alive = true

func _physics_process(delta):
	apply_input()

	velocity.y += gravity
	var collision  = move_and_collide(velocity * delta)
	if collision && is_alive:
		is_alive = false
		emit_signal("player_death", self)

func play_death_choreograhpy():
	input_enabled = false
	collision_shape.disabled = true
	anim_player.play("death")
