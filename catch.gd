extends Area2D

func _on_body_entered(body):
	if not (body is Ball): return
	body.reset()
