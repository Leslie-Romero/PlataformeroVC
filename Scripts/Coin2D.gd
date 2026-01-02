extends Area2D

func _ready():
	$AnimationPlayer.play("coin")


func _on_body_entered(body):
	queue_free()
	pass # Replace with function body.
