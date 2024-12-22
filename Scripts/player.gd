extends CharacterBody2D

@export var speed = 150
@export var gravity = 30
@export var jumpForce = 400
@export var objectScene = preload("res://Scenes/SettingsButton.tscn")
const PUSH_FORCE = 15.0
const MIN_PUSH_FORCE = 10.0
var offset = 0
#https://www.youtube.com/watch?v=LOhfqjmasi0&ab_channel=Brackeys
var direction = Vector2.RIGHT
var pressedEscape = false
var spawnedObject
var settingsButton
var draggingPossible = false

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
	
	#allow the player to push objects
	for i in range(get_slide_collision_count()):
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var push_force = MIN_PUSH_FORCE * 2
			var collider = c.get_collider()
			var normal = c.get_normal()
			
			collider.apply_central_impulse(-normal * push_force)
	
	#check for object spawning
	if Input.is_action_just_pressed("spawn_object"):
		#pause the game
		#enable the pressed escape var then check if there is already a settings box there
		if !pressedEscape:
			spawn_object()
		elif pressedEscape and spawnedObject != null:
			settingsButton.enable_button()
		
func spawn_object():
	#spawn the object as child of player
	spawnedObject = objectScene.instantiate()
	get_parent().add_child(spawnedObject)
	
	#set the offset based on direction
	#if direction == Vector2.RIGHT:
		#offset = 20
	#else:
		#offset = 100
		
	#setting offsets
	var y_offset = -50
	offset = -35
	
	#spawnedObject.position = global_position + (direction.normalized() * offset)
	spawnedObject.position = global_position + Vector2(offset, y_offset)
	
	settingsButton = spawnedObject
	settingsButton.disable_button()
	
	pressedEscape = true


func set_dragging_true():
	draggingPossible = true
func set_dragging_false():
	draggingPossible = false
