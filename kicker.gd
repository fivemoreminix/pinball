extends Area2D
class_name Kicker

@export var max_impulse : float   = 2000.0
@onready var direction  : Vector2 = Vector2(cos(rotation + (PI/2)), sin(rotation + (PI/2))) * max_impulse

func _on_body_entered(body):
	if body is Ball:
		#body.apply_impulse(direction)
		body.apply_impulse((Vector2.UP*max_impulse)+(body.linear_velocity.reflect(Vector2.LEFT)))
