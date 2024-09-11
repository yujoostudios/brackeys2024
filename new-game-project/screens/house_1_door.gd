extends Area2D

var highlight = preload("res://assets/art/house-1-door-highlighted.png")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("body entered")
		$Sprite2D.texture = highlight
