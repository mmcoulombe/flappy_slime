extends RigidBody2D

signal player_death(player)
signal player_jumped()

export(int) var flap_force = 250

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

func apply_input(delta):
	if input_enabled:
		var flap = Input.is_action_just_pressed("ui_up")
		if flap:
			applied_force = Vector2.ZERO
			linear_velocity = Vector2.ZERO
			apply_central_impulse(Vector2(0, -1 * flap_force))
			emit_signal("player_jumped")

	if not is_alive:
		if Input.is_action_just_released("restart"):
			get_tree().reload_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	is_alive = true
	
func _physics_process(delta):
	apply_input(delta)

func play_death_choreograhpy():
	input_enabled = false
	collision_shape.disabled = true
	anim_player.play("death")

func die():
	if is_alive:
		is_alive = false
		emit_signal("player_death", self)	

func _on_player_screen_exited():
	die()

func _on_player_body_entered(body):
	print('body enterred')
	if is_alive:
		die()
