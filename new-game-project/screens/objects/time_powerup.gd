extends Area2D

signal TimePowerUpActivate

func _on_area_entered(area: Area2D) -> void:
	emit_signal("TimePowerUpActivate")
	queue_free()
