extends Node
 
var server := UDPServer.new()
var json := JSON.new()
 
func _ready():
	var ok = server.listen(6005)
	if ok != OK:
		print("Error al abrir el puerto UDP")
	else:
		print("Godot escuchando en puerto 6005...")
 
func _process(delta):
	# Aceptar nuevos emisores de datos
	server.poll()
 
	# Obtener una lista de todas las conexiones UDP
	while server.is_connection_available():
		var peer = server.take_connection()
		var data = peer.get_packet().get_string_from_utf8()
		var parsed = json.parse(data)
		if parsed == OK:
			var json_data = json.data
			if json_data["move_right"] == 1:
				_move_x("derecha")
			elif json_data["move_left"] == 1:
				_move_x("izquierda")
			elif json_data["jump"] == 1:
				_jump()
			elif json_data["shoot"] == 1:
				_shoot()
			elif json_data["crouch"] == 1:
				_crouch()

 
func _move_x(direction):
	print("Moviendose hacia la ", direction)
	if direction == "izquierda":
		Global.move_x = 1
	elif direction == "derecha":
		Global.move_x = 0
func _crouch():
	print("Crouch")
	Global.slide = 1
func _jump():
	print("Jump!")
	Global.jump = 1
func _shoot():
	print("Shoot")
	Global.attack = 1
