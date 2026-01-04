extends Area2D

signal coinCollected

func _ready():
	if name in Global.collected_coins:
		queue_free()
	else:
		$AnimationPlayer.play("coin")

func _on_body_entered(body):
	if body.name == "Player": 
		Global.collected_coins.append(name)
		coinCollected.emit() 
		queue_free()
