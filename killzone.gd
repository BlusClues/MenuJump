extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body:Node2D ) -> void:
	if body == $"../Player":
		print("Flirted With Death")
		timer.start()
	
	if body != $"../Player":
		body.queue_free()
		print("object killed")


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
