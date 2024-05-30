extends CharacterBody2D
class_name Plunger


@export var punch_time           : float   = 0.05
@export var retract_time         : float   = 2.5
@export var max_retract_distance : float   = 1.0

@onready var start_pos           : Vector2 = position
var tween                        : Tween 

func _ready():
	tween = create_tween()
	tween.stop()

func _input(event):
	if Input.is_action_just_pressed("plunger"):
		if tween.is_valid:
			if tween.is_running(): return
		prints("Pulling plunger.")
		tween = create_tween()
		tween.tween_property(self, "position/y", start_pos.y + max_retract_distance, retract_time)
	
	if Input.is_action_just_released("plunger"):
		tween = create_tween()
		tween.tween_property(self, "position/y", start_pos.y, punch_time)
