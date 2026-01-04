extends CharacterBody2D

const moveSpeed = 25
const maxSpeed = 50 
const jumpHeight = -300
const gravity = 15

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer 
var jump_cooldown = 0.0

func _ready():
	if Global.checkpoint_pos != null:
		global_position = Global.checkpoint_pos

func _physics_process(delta):
	velocity.y += gravity
	var friction = false
	
	if jump_cooldown > 0:
		jump_cooldown -= delta
		
	if not is_on_floor() or jump_cooldown > 0:
		if Global.jump != 0:
			Global.jump = 0
	
	if Global.slide == 1:
		animationPlayer.stop()
		animationPlayer.play("Slide")
		Global.slide = 0

	var is_sliding = animationPlayer.is_playing() and animationPlayer.current_animation == "Slide"
	
	if Global.move_x == 0:
		sprite.flip_h = true 
		if not is_sliding:
			animationPlayer.play("Walk")
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
		Global.move_x = 2
	elif Global.move_x == 1:
		sprite.flip_h = false 
		if not is_sliding:
			animationPlayer.play("Walk")
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
		Global.move_x = 2
	else:
		if not is_sliding:
			animationPlayer.play("Idle")
		friction = true
	
	
	
	if is_on_floor():
		if jump_cooldown <= 0:
			if Global.jump == 1: 
				sprite.flip_h = true 
				velocity.y = jumpHeight
				velocity.x = maxSpeed * 1.5
				Global.jump = 0
				jump_cooldown = 0.2
			elif Global.jump == 2:
				sprite.flip_h = false
				velocity.y = jumpHeight
				velocity.x = -maxSpeed * 1.5
				Global.jump = 0
				jump_cooldown = 0.2
			
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.2) 
	else:
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.01) 
	
	if Global.attack == 1:
		Global.attack = 0
	
	move_and_slide()

	for i in get_slide_collision_count():
		var colision = get_slide_collision(i)
		var objeto = colision.get_collider()
		if objeto is TileMap:
			var coords = objeto.local_to_map(objeto.to_local(colision.get_position()))
			var data = objeto.get_cell_tile_data(0, coords)
			if data:
				var layer_id = objeto.tile_set.get_custom_data_layer_by_name("mortal")
				if layer_id != -1:
					if data.get_custom_data_by_layer_id(layer_id) == true:
						get_tree().reload_current_scene()
