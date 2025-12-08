extends Node2D

var server := TCPServer.new()
var client: StreamPeerTCP = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var result = server.listen(9000)
	if result != OK:
		print("Error al iniciar el servidor")
	else:
		print("Servidor esperando conexión...")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	 # Si no hay cliente aún, aceptar uno nuevo
	if client == null and server.is_connection_available():
		client = server.take_connection()
		client.set_no_delay(true)
		print("Cliente conectado")

	# Si ya tenemos cliente:
	if client != null and client.get_available_bytes() > 0:
		var raw = client.get_utf8_string(client.get_available_bytes())
		for line in raw.split("\n"):
			if line.strip_edges() != "":
				var json_data = JSON.parse_string(line)
				if json_data != null:
					_handle_commands(json_data)

func _handle_commands(cmd):
	var move_x = cmd.get("move_x", 0)
	var jump = cmd.get("jump", 0)
	var attack = cmd.get("attack", 0)
	
	# Emitir señales, actualizar variables globales, etc.
	Global.move_x = move_x
	Global.jump = jump
	Global.attack = attack
