extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Global.checkpoint_pos = global_position
		print("Checkpoint guardado en: ", global_position)
