extends CanvasLayer

var coins = 00

func _ready():
	var coinsNode = get_tree().get_nodes_in_group("monedas")
	
	for coin in coinsNode:
		# Sintaxis de Godot 4: señal.connect(nombre_de_la_funcion)
		coin.coinCollected.connect(handleCoinCollected)
	
	$CoinsCollected.text = str(coins)

func handleCoinCollected():
	print("Moneda recogida")
	coins += 1
	$CoinsCollected.text = str(coins)
