# Player.gd
extends Node2D  # si no usáis CharacterBody2D, poned Node2D y adapted position updates

@export var speed: float = 200.0
@export var jump_strength: float = -350.0

var _velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	# movimiento horizontal básico
	_velocity.x = Global.move_x * speed

	# salto (ejemplo simple)
	if Global.jump == 1:
		if is_on_floor():
			_velocity.y = jump_strength
		# si queréis que jump sea solo un pulso, resetear:
		Global.jump = 0

	# ataque / defensa: gestionadlos aquí (p.ej. lanzar proyectil)
	if Global.attack == 1:
		print("Fire projectile!")
		Global.attack = 0

	if Global.defend == 1:
		print("Activate shield!")
		Global.defend = 0

	# gravedad básica y movimiento
	_velocity.y += 20 * delta * 60  # ejemplo de gravedad; ajustad según vuestro motor
	move_and_slide()
