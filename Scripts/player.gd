extends CharacterBody2D

@export var speed = 150
@export var gravity = 30
@export var jumpForce = 400
@export var settings = preload("res://Scenes/SettingsButton.tscn")
@export var restart = preload("res://Scenes/restartButton.tscn")
@export var quit = preload("res://Scenes/quitButton.tscn")
const PUSH_FORCE = 15.0
const MIN_PUSH_FORCE = 10.0
#https://www.youtube.com/watch?v=LOhfqjmasi0&ab_channel=Brackeys
var direction = Vector2.RIGHT
var pressedEscape = false
var spawnedObjectSettings
var spawnedObjectRestart
var spawnedObjectQuit
var settingsButton
var restartButton
var quitButton
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
		if spawnedObjectSettings == null and spawnedObjectRestart == null and spawnedObjectQuit == null:
			spawn_object()
			pressedEscape = true
		else:
			if is_instance_valid(spawnedObjectSettings) and is_instance_valid(spawnedObjectRestart) and is_instance_valid(spawnedObjectQuit):
				if pressedEscape:
					#Enable buttons (make draggable)
					settingsButton.enable_button()
					restartButton.enable_button()
					quitButton.enable_button()
					pressedEscape = false
				else:
					#Disable buttons (lock them)
					settingsButton.disable_button()
					restartButton.disable_button()
					quitButton.disable_button()
					pressedEscape = true
			else:
				reset_button_states()
		
func reset_button_states():
	# Reset references if objects have been deleted
	spawnedObjectSettings = null
	spawnedObjectRestart = null
	spawnedObjectQuit = null
	pressedEscape = false

func spawn_object():
	#spawn the object as child of player
	spawnedObjectSettings = settings.instantiate()
	get_parent().add_child(spawnedObjectSettings)
	
	spawnedObjectRestart = restart.instantiate()
	get_parent().add_child(spawnedObjectRestart)
	
	spawnedObjectQuit = quit.instantiate()
	get_parent().add_child(spawnedObjectQuit)
	
	#set the offset based on direction
	#if direction == Vector2.RIGHT:
		#offset = 20
	#else:
		#offset = 100
		
	#setting offsets
	var y_offset_settings = -140
	var x_offset_settings = -35
	
	var y_offset_restart = -105
	var x_offset_restart = -85
	
	var y_offset_quit = -70
	var x_offset_quit = -50
	
	#adjusting position of the button
	#spawnedObject.position = global_position + (direction.normalized() * offset)
	spawnedObjectSettings.position = global_position + Vector2(x_offset_settings, y_offset_settings)
	spawnedObjectRestart.position = global_position + Vector2(x_offset_restart, y_offset_restart)
	spawnedObjectQuit.position = global_position + Vector2(x_offset_quit, y_offset_quit)
	
	#disabling the button physics when it spawns
	settingsButton = spawnedObjectSettings
	settingsButton.disable_button()
	
	restartButton = spawnedObjectRestart
	restartButton.disable_button()
	
	quitButton = spawnedObjectQuit
	quitButton.disable_button()
	
	pressedEscape = true


func set_dragging_true():
	draggingPossible = true
func set_dragging_false():
	draggingPossible = false
