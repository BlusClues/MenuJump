extends RigidBody2D

@onready var collisionShape = $CollisionShape2D
@onready var button = $Button

var dragging = false
var of = Vector2(0,0)
var disabled = true

func disable_button():
	collisionShape.disabled = true
	gravity_scale = 0
	disabled = true
	
func enable_button():
	collisionShape.disabled = false
	gravity_scale = 1
	dragging = false
	disabled = false

func _process(delta):
	if dragging == true and disabled == true:
		position = get_global_mouse_position() - of
	
func _on_button_button_down() -> void:
	dragging = true
	button.set_dragging()
	of = get_global_mouse_position() - global_position
	
func _on_button_button_up() -> void:
	dragging = false
