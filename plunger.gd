extends Area2D
class_name Plunger


@export var punch_time           : float   = 0.01
@export var retract_time         : float   = 2.5
@export var max_retract_distance : float   = 1.0
@export var max_impulse          : float   = 2500.0

@onready var start_pos           : Vector2 = position
var tween                        : Tween 
var ball                         : Ball


func _ready() -> void:
	tween = create_tween()
	tween.stop()


func _input(event) -> void:
	if Input.is_action_just_pressed("plunger"):
		if tween.is_valid:
			if tween.is_running(): return
		prints("Pulling plunger.")
		tween = create_tween()
		tween.tween_property($Sprite2D, "position/y", start_pos.y + max_retract_distance, retract_time)
	
	if Input.is_action_just_released("plunger"):
		prints("Releasing plunger.")
		tween = create_tween()
		tween.tween_property($Sprite2D, "position/y", start_pos.y, punch_time)
		punch()


func _on_body_entered(body) -> void:
	if body is Ball:
		ball = body


func _on_body_exited(body) -> void:
	if body is Ball:
		ball = null


func punch() -> void:
	if ball:
		ball.apply_impulse(Vector2.UP * max_impulse)
