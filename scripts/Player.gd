extends KinematicBody2D
export (float, 0 , 1.0) var friction = 0.1
export (float, 0 , 1.0) var acceleration = 0.25
#96 is tile size
const SLOPE_STOP = 64
export (int) var speed = 5 * 96
export (int) var jump_speed = -500
export (int) var gravity = 1200
var velocity = Vector2.ZERO

var is_jumping
var is_grounded
onready var cam = $Camera2D
onready var raycasts = $Raycasts
onready var anim_player = $Body/AnimatedSprite
onready var collider = $CollisionShape2D

var hidden = false

# Called when the node enters the scene tree for the first time.
func _ready():
	cam.make_current()
	
func _handle_move_input():
	if !hidden:
		var dir = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
		velocity.x = lerp(velocity.x, dir * speed, _get_h_weight())
		if dir != 0:
			$Body.scale.x = dir
			

func _apply_gravity(delta):
	#apply gravity
	if !hidden:
		velocity.y += gravity * delta
func _apply_movement():
	#move the player
	if !hidden:
		velocity = move_and_slide(velocity, Vector2.UP, SLOPE_STOP)
		is_grounded = _check_is_grounded()
	

func _get_h_weight():
	return 0.25 if is_grounded else 0.1
func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
			
	return false
func _pauseAndHide():
	#hide()
	hidden = true
	$Body/AnimatedSprite.modulate = "64ffffff" # see through
	pass
func _resume():
	hidden = false
	$Body/AnimatedSprite.modulate = "ffffffff" # see through
	show()
	cam.make_current()
