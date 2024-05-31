@tool
extends PinJoint2D
class_name PaddlePhys2


@export var is_left        : bool    = true
@export var start_rotation : float   = -10.0
@export var stop_rotation  : float   = 45.0
@export var rotation_time  : float   = 0.025

@onready var start_pos     : Vector2 = position

var tween                  : Tween
var actuate_rotation       : float
var release_rotation       : float


func _ready():
	rotation         = deg_to_rad(start_rotation)
	actuate_rotation = deg_to_rad(stop_rotation)
	release_rotation = rotation
	tween = create_tween()


func _process(delta):
	if !Engine.is_editor_hint(): return
	$Paddle.rotation = deg_to_rad(start_rotation)

'''
func _integrate_forces(state):
	state.linear_velocity = Vector2.ZERO
	linear_velocity = Vector2.ZERO
	position = start_pos
'''

func _input(event) -> void:
	var action = "left_paddle" if is_left else "right_paddle"
	if event.is_action_pressed(action):
		motor_enabled = true
	if event.is_action_released(action):
		motor_enabled = false


func actuate() -> void:
	tween = create_tween()
	tween.tween_property(self, "rotation", actuate_rotation, rotation_time)


func release() -> void:
	tween = create_tween()
	tween.tween_property(self, "rotation", release_rotation, rotation_time)
