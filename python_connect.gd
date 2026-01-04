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
	server.poll()
 
	while server.is_connection_available():
		var peer = server.take_connection()
		var data = peer.get_packet().get_string_from_utf8()
		var parsed = json.parse(data)
		if parsed == OK:
			var json_data = json.data
			if json_data["jump"] != 0:
				_jump(json_data["jump"])
			elif json_data["move_right"] == 1:
				_move_x("derecha")
			elif json_data["move_left"] == 1:
				_move_x("izquierda")
			elif json_data["attack"] == 1:
				_attack()
			elif json_data["slide"] == 1:
				_slide()

 
func _move_x(direction):
	print("Moviendose hacia la ", direction)
	if direction == "izquierda":
		Global.move_x = 1
	elif direction == "derecha":
		Global.move_x = 0
	else:
		Global.move_x = 2
func _slide():
	print("Slide")
	Global.slide = 1
func _jump(jump_type):
	Global.jump = jump_type
	if jump_type == 1:
		print("Jump right!")
	elif jump_type == 2:
		print("Jump left!")
func _attack():
	print("Shoot")
	Global.attack = 1
