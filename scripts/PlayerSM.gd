extends "res://scripts/StateMachine.gd"

var active = true

func _ready():
	add_state("idle")
	add_state("move")
	add_state("jump")
	add_state("inactive")
	call_deferred("set_state", states.idle)


func _input(event):
	if [states.idle, states.move].has(state):
		if event.is_action_pressed("ui_up") && parent.is_on_floor():
			parent.velocity.y = parent.jump_speed
	if event.is_action_pressed("ui_accept"):
		if active == true:
			parent._pauseAndHide()
		else: 
			parent._resume()
		active = !active
func _state_logic(delta):
	if state != states.inactive:
		parent._handle_move_input()
		parent._apply_gravity(delta)
		parent._apply_movement()
	else:
		return
func _get_transition(delta):
	match state:
		states.idle:
			if active != false:
				if !parent.is_on_floor():
						if parent.velocity.y < 0 or parent.velocity.y > 0:
							return states.jump
							
				elif abs(parent.velocity.x) >= 300:
					return states.move
			else:
				return states.inactive
		states.move:
			if active != false:
				if !parent.is_on_floor():
						if parent.velocity.y < 0 or parent.velocity.y > 0:
							return states.jump
				elif abs(parent.velocity.x) <= 250:
					return states.idle
				if (Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right")):
					return states.idle
			else:
				return states.inactive
		states.jump:
			if active != false:
				if parent.is_on_floor():
					return states.idle
			#return states.inactive
		states.inactive:
			if active == true:
				return states.idle
	return null

func _enter_state(new_state, old_state):
	#print(new_state)
	match new_state:
		states.idle:
			parent.anim_player.play("idle_blue")
			parent.collider.scale.x = 0.3
		states.move:
			parent.anim_player.play("run_blue")
			parent.collider.scale.x = 0.5			
		states.jump:
			parent.anim_player.play("jump_blue")
			parent.collider.scale.x = 0.3
		states.inactive:
			pass
	
func _exit_state(old_state, new_state):
	pass

