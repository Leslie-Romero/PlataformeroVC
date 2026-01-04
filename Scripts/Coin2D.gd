extends Area2D

signal coinCollected

func _ready():
	var coin_id = str(get_path())
	if coin_id in Global.collected_coins:
		queue_free()
	else:
		$AnimationPlayer.play("coin")

func _on_body_entered(body):
	if body.name == "Player": 
		var coin_id = str(get_path())
		if not coin_id in Global.collected_coins:
			Global.collected_coins.append(coin_id)
			coinCollected.emit() 
		queue_free()
