#extends "res://scripts/StateMachine.gd"
#
#var active = false
#
#func _ready():
#	add_state("move")
#	add_state("Swing")
#	add_state("inactive")
#	call_deferred("set_state", states.inactive)
#	parent._pauseAndHide()
#
#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		if active == true:
#			parent._pauseAndHide()
#		else:
#			parent._resume()
#		active = !active

#func _state_logic(delta):
#	if state == states.move:
#		parent.move_character()
#		parent.detect_turn_around()
#	elif state == states.inactive:
#		return
#	else:
#		return
#
#
#func _get_transition(delta):
#	match state:
#		states.move:
#			if active != false:
#				if parent.anim_player.current_animation == "Swing":
#					return states.Swing
#			return states.inactive
#		states.Swing:
#			if active != false:
#				if !parent.anim_player.is_playing():
#					return states.move
#			return states.inactive
#		states.inactive:
#			if active == true:
#				return states.move
#	return null
#
#func _enter_state(new_state, old_state):
#	match new_state:
#		states.move:
#			parent.anim_player.play("move")
#		states.Swing:
#			parent.anim_player.play("Swing")
#		states.inactive:
#			pass
#
#func _exit_state(old_state, new_state):
#	pass
#
#
