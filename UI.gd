extends CanvasLayer

var coins = 00

func _ready():
	coins = Global.total_coins
	var coinsNode = get_tree().get_nodes_in_group("monedas")
	
	for coin in coinsNode:
		coin.coinCollected.connect(handleCoinCollected)
	
	$CoinsCollected.text = str(coins)

func handleCoinCollected():
	print("Moneda recogida")
	coins += 1
	Global.total_coins = coins
	$CoinsCollected.text = str(coins)
