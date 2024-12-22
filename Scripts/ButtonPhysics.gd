extends Node2D

@export var gravity = 30
#store the falling speed
var velocity = Vector2.ZERO

@onready var button = $ResumeButton

func _physics_process(delta: float):
	#applys Gravity
	velocity.y += gravity * delta
	
	#move the button
	position.y += velocity.y * delta
	
	#stop the button when it hits the ground
	if position.y >= 500:
		position.y = 500
		velocity.y = 0
	
