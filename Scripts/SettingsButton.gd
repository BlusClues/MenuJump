extends Button

@export var objectScene = preload("res://Scenes/AudioButton.tscn")
var spawnedObjectInstance : Node = null
@onready var draggingobject = $".."
var dragging = false

func _on_pressed() -> void:
	#if draggingobject.dragging == true:
	#dragging = true
	
	if not is_instance_valid(spawnedObjectInstance) and Input.is_action_pressed("spawn_audio"):
		#if !dragging:
		spawn_object()
	
func spawn_object():
	if not objectScene:
		print("Object scene is not set!")
		return
		
	# Spawn the object and add it to the correct parent
	spawnedObjectInstance = objectScene.instantiate()
	var parentNode = get_tree().get_root().get_node("World")
	
	if parentNode:
		parentNode.add_child(spawnedObjectInstance)
		# Set its position
		spawnedObjectInstance.global_position = self.global_position
	else:
		print("Parent node 'World' not found!")
		
		
func set_dragging():
	dragging = !dragging
