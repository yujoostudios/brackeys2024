extends Area2D

class_name pickup
@export var node_type : ResourceNodeType
signal money_change

func _ready() -> void:
	$Sprite2D.texture = load(node_type.regular_pic)

func _on_timer_timeout() -> void:
	if Input.is_action_pressed("interact"):
		emit_signal("money_change", node_type.value)
		queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea":
		$Sprite2D.texture = load(node_type.highlight_pic)
	$Timer.start()
	print(node_type.item_name)
	print(node_type.value)

func _on_area_exited(area: Area2D) -> void:
	if area.name == "PlayerArea":
		$Sprite2D.texture = load(node_type.regular_pic)
		$Timer.stop()
	
