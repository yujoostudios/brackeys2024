extends Area2D

signal SpeedPowerUpActivate

func _on_area_entered(area: Area2D) -> void:
	emit_signal("PowerUpActivate", true)
	queue_free()
