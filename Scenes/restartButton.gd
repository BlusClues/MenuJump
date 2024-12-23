extends Button

@export var objectScene = preload("res://Scenes/restartButton.tscn")
var spawnedObjectInstance : Node = null
@onready var draggingobject = $".."
var dragging = false

func _on_pressed() -> void:
	if draggingobject.dragging == true:
		dragging = true
	
	if not is_instance_valid(spawnedObjectInstance) and Input.is_action_pressed("spawn_audio"):
		#if !dragging:
		reload_scene()
	
func set_dragging():
	dragging = !dragging

func reload_scene():
	get_tree().reload_current_scene()
	print("reloading scene")
