extends Control

var total_value = 0
const MONEY_OBJECTIVE = 10000
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	set_money_objective()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Receive signal from Player (whenever they walk type shit)
	var house1level = get_tree().get_first_node_in_group("house")
	house1level.connect("send_noise_value", self.calc_noise_meter_color)
	
	var items = get_tree().get_nodes_in_group("items")
	for item in items:
		item.connect("money_change", self._update_money)
	pass


func calc_noise_meter_color(value : int):
	$ProgressBar.value = value
	#print($ProgressBar.value)
	if value > 75 && value < 90:
		$ProgressBar.get("theme_override_styles/fill").bg_color = Color(0.89, 0.4, 0.2)
	elif value >= 90:
		$ProgressBar.get("theme_override_styles/fill").bg_color = Color(0.75686274509, 0.20392156862, 0.10588235294)
	else:
		$ProgressBar.get("theme_override_styles/fill").bg_color = Color(0.06274509803, 0.58431372549, 0.52156862745)

# All nodes in group items will run this function
func _update_money(value : int):
	total_value = total_value + value
	$HBoxContainer/Label.text = str(total_value)

func _on_ui_extend(value : int):
	$HBoxContainer/Label.text = str()
	
func set_money_objective():
	$ObjectiveLabel.text = "Objective: Steal $" + str(MONEY_OBJECTIVE) + " worth of items."
