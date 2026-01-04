extends Area2D

func _ready():
	if Global.checkpoint_pos == global_position:
		modulate = Color(0, 1, 0)

func _on_body_entered(body):
	if body.name == "Player":
		if Global.checkpoint_pos != global_position:
			Global.checkpoint_pos = global_position
			
			var tween = create_tween()
			tween.tween_property(self, "modulate", Color(0.3, 1, 0.3), 0.2)
			tween.parallel().tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
			tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
