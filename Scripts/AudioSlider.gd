extends HSlider

@onready var button = $".."
@onready var Collider = $"../../CollisionShape2D"
@onready var RigidBody = $"../.."

func _on_drag_ended(value_changed: bool) -> void:
	var value = get_value()
	
	RigidBody.Transform.y.Scale = value
	#button.scale = Vector2(value / 100, value / 100)
	#Collider.scale = Vector2(value / 150, value / 150)
	#RigidBody.scale = Vector2(value , value )
	
	# Adjust the size of the collision shape to match the scaling
	#if Collider.shape is RectangleShape2D:
		##shape.extents = Vector2(value / 100, value / 100)  # Adjust the extents based on the scale
	
	# Adjust the RigidBody's position to prevent it from getting stuck in the floor
	#RigidBody.position.y += -200  # Move the RigidBody upwards by 10px
