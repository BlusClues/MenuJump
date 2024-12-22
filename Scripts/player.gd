extends CharacterBody2D

@export var speed = 150
@export var gravity = 30
@export var jumpForce = 400
@export var objectScene = preload("res://Scenes/ResumeButton.tscn")
var offset
#https://www.youtube.com/watch?v=LOhfqjmasi0&ab_channel=Brackeys
var direction = Vector2.RIGHT

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
		direction = Vector2.RIGHT
		animatedSprite.flip_h = false
	elif horizontalDirection < 0:
		direction = Vector2.LEFT
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
	
	#check for object spawning
	if Input.is_action_just_pressed("spawn_object"):
		spawn_object()
		
		
func spawn_object():
	#spawn the object as child of player
	var spawnedObject = objectScene.instantiate()
	get_parent().add_child(spawnedObject)
	
	#set the offset based on direction
	if direction == Vector2.RIGHT:
		offset = 20
	else:
		offset = 100
	
	spawnedObject.position = global_position + (direction.normalized() * offset)
