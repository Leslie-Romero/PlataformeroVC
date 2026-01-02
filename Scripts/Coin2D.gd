extends Area2D

signal coinCollected

func _ready():
	$AnimationPlayer.play("coin")

func _on_body_entered(body):
	if body.name == "Player": 
		coinCollected.emit() 
		queue_free()
