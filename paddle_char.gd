extends CharacterBody2D
class_name test_paddle_char


@export var is_left        : bool = true
@export var start_rotation : float = -10.0
@export var stop_rotation  : float = 45.0
@export var rotation_time  : float = 0.05
@export var torque         : float = 100_000_000 # I have no idea what unit this is in

var tween                  : Tween
var actuate_rotation       : float
var release_rotation       : float
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	if is_left:
		rotation         = deg_to_rad(start_rotation)
		actuate_rotation = deg_to_rad(stop_rotation)
	else:
		rotation         = deg_to_rad(start_rotation)
		actuate_rotation = deg_to_rad(stop_rotation)
	release_rotation = rotation
	tween = create_tween()

func _input(event) -> void:
	var action = "ui_left" if is_left else "ui_right"
	
	if event.is_action_pressed(action):
		actuate()
	if event.is_action_released(action):
		release()


func actuate() -> void:
	tween = create_tween()
	tween.tween_property(self, "rotation", actuate_rotation, rotation_time)


func release() -> void:
	tween = create_tween()
	tween.tween_property(self, "rotation", release_rotation, rotation_time)
