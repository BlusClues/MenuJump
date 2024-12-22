extends Button

@export var objectScene = preload("res://Scenes/AudioButton.tscn")

func _on_button_pressed() -> void:
	spawn_object()
	
	
func spawn_object():
	#spawn the object as child of player
	var spawnedObject = objectScene.instantiate()
	get_parent().add_child(spawnedObject)
