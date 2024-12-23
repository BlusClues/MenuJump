#extends RigidBody2D
extends Button

@export var objectScene = preload("res://Scenes/restartButton.tscn")
var spawnedObjectInstance : Node = null
@onready var draggingobject = $".."
var dragging = false

#func _on_pressed() -> void:
	#if draggingobject.dragging == true:
	#dragging = true
	
	#if not is_instance_valid(spawnedObjectInstance):
		#if !dragging:
			#spawn_object()
	
func set_dragging():
	dragging = !dragging
# Export variables for easy setup in the inspector
#@onready var object_to_scale = $"."
#@onready var collision_shape = $CollisionShape2D
#@onready var slider = $Button/HSlider

#func _ready():
	# Connect the slider value changed signal to the method
	#slider.connect("value_changed", Callable(self, "_on_slider_value_changed"))
	
	# Initialize the object with the slider value
	#_on_slider_value_changed(slider.value)
	
#func _on_slider_value_changed(value: float):
	# Scale the object by the slider's value
	#object_to_scale.scale = Vector2(value, value)
	   
	# Adjust the collision shape based on the new scale
	#if collision_shape:
		# Assuming you're using a BoxShape as the collision shape
		#var box_shape = collision_shape.shape as BoxShape3D
		#if box_shape:
			# Set the new size of the collision box to match the scale
			#box_shape.extents = object_to_scale.scale * 0.5  # Divide by 2 because BoxShape extents are half the size
