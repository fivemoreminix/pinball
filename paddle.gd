extends RigidBody2D

@export var is_left: bool = true
@export var start_rotation: float = 0.0
@export var stop_rotation: float = 45.0
@export var torque: float = 100_000_000 # I have no idea what unit this is in

var pressed: bool = false


func _process(delta):
	pressed = Input.is_action_pressed("ui_left" if is_left else "ui_right")


func _integrate_forces(state: PhysicsDirectBodyState2D):
	var dir_torque = torque * (-1 if is_left else 1)
	state.linear_velocity = Vector2.ZERO
	
	if pressed:
		if (is_left and rotation_degrees < -stop_rotation) or not is_left and (rotation_degrees > stop_rotation):
			state.angular_velocity = 0
			rotation_degrees = stop_rotation
		else:
			state.apply_torque(dir_torque * state.step)
	else: # Return the paddle to the default position
		if (is_left and rotation_degrees < start_rotation) or (not is_left and rotation_degrees < start_rotation):
			state.apply_torque(-dir_torque * state.step)
		else:
			state.angular_velocity = 0
			rotation_degrees = start_rotation
