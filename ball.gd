extends RigidBody2D
class_name Ball

@onready var start_pos = position
var reset_state = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.global_rotation = 0


func reset() -> void:
	reset_state = true


func _integrate_forces(state):
	if reset_state:
		position = start_pos
		reset_state = false
