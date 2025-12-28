extends CharacterBody2D

const moveSpeed = 25
const maxSpeed = 50 
const jumpHeight = -300
const gravity = 15

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer 

func _physics_process(delta):
		
	velocity.y += gravity
	
	var friction = false
	
	if Global.move_x == 0:
		sprite.flip_h = true 
		animationPlayer.play("Walk")
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
		Global.move_x = 2
		
	elif Global.move_x == 1:
		sprite.flip_h = false 
		animationPlayer.play("Walk")
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
		Global.move_x = 2
		
	else:
		animationPlayer.play("Idle")
		friction = true
	
	if is_on_floor():
		# Derecha
		if Global.jump == 1: 
			sprite.flip_h = true 
			velocity.y = jumpHeight
			velocity.x = maxSpeed * 0.8
			Global.jump = 0
		# Izquierda
		elif Global.jump == 2:
			sprite.flip_h = false
			velocity.y = jumpHeight
			velocity.x = -maxSpeed * 0.8
			Global.jump = 0
			
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.2) 
	else:
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.05) 
	
	if Global.attack == 1:
		print("Atacando")
		#animationPlayer.play("Attack")
		Global.attack = 0
	
	if Global.slide == 1:
		print("Agachado")
		animationPlayer.play("Slide")
		Global.slide = 0
	
	move_and_slide()
