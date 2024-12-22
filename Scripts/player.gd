extends CharacterBody2D

@export var speed = 150
@export var gravity = 30
@export var jumpForce = 400
#https://www.youtube.com/watch?v=LOhfqjmasi0&ab_channel=Brackeys

@onready var animatedSprite = $AnimatedSprite2D

func _physics_process(delta: float):
	#adds Gravity
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	#Handle Jump
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jumpForce
	
	# get the input direction of the player
	var horizontalDirection = Input.get_axis("move_left", "move_right")
	
	#flip the sprite
	if horizontalDirection > 0:
		animatedSprite.flip_h = false
	elif horizontalDirection < 0:
		animatedSprite.flip_h = true
		
	#play animations
	if is_on_floor():
		if horizontalDirection == 0:
			animatedSprite.play("Player_idle")
		else:
			animatedSprite.play("Player_walk")
	else:
		animatedSprite.play("Player_jump")
	
	#Handle Movement
	velocity.x = horizontalDirection * speed
	
	move_and_slide()
