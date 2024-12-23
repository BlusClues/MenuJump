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
