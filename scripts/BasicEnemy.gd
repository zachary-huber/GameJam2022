extends KinematicBody2D
var active = false
var is_moving_left = true
var gravity = 10
var velocity = Vector2.ZERO
onready var raycast = $RayCast2D
onready var anim_player= $AnimationPlayer
onready var Attack = $AttackDetector
var speed = 100

func _ready():
	hide()


func _input(event):
	if event.is_action_pressed("ui_accept"):
		if active == true:
			_pauseAndHide()
		else:
			_resume()
		active = !active

func _process(_delta):
	if active == true:
		if anim_player.current_animation == "Swing":
			return
		move_character()
		detect_turn_around()
	else:
		return
func move_character():
	if is_moving_left:
		velocity.x = -speed
	else: velocity.x = speed 
	velocity .y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
func hit():
	Attack.monitoring = true
func end_of_hit():
	Attack.monitoring = false

func _on_PlayerDetector_body_entered(body):
	anim_player.play("Swing")

func start_walk():
	anim_player.play("move")
func _on_AttackDetector_body_entered(body):
	get_tree().reload_current_scene()


func _pauseAndHide():
	hide()
func _resume():
	show()
	


