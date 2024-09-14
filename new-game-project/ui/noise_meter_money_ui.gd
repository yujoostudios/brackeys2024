extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = global.noise_meter_value
	calc_noise_meter_color()
	_update_money()
	pass

func calc_noise_meter_color():
	if global.noise_meter_value > 75 && global.noise_meter_value < 90:
		$ProgressBar.get("theme_override_styles/fill").bg_color = Color(0.89, 0.4, 0.2)
	elif global.noise_meter_value >= 90:
		$ProgressBar.get("theme_override_styles/fill").bg_color = Color(0.75686274509, 0.20392156862, 0.10588235294)
	else:
		$ProgressBar.get("theme_override_styles/fill").bg_color = Color(0.06274509803, 0.58431372549, 0.52156862745)

func _update_money():
	$HBoxContainer/Label.text = str(global.total_money)
