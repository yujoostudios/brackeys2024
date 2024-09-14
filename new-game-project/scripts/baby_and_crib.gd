extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var house1level = get_tree().get_first_node_in_group("house")
	house1level.connect("send_noise_value", self.animate)
	pass

func animate(value : int):
	if value > 99:
		$AnimationPlayer.play("crying")
