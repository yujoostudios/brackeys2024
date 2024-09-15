extends Node2D

@onready var baby = $Furniture/BabyAndCrib
@onready var player = $Player

@export var house_type : HouseNodeType

var noise_meter_value = 0

signal send_noise_value
signal stop_player_movement
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	calc_noise_meter_value()
	emit_signal("send_noise_value", noise_meter_value)
	
	var clock = get_tree().get_first_node_in_group("clock")
	clock.connect("time_over", self._game_over_overlay)
	
	var noise = get_tree().get_first_node_in_group("noise")
	noise.connect("noise_limit", self._game_over_overlay)

# Calculate the current distance between player and baby
func calc_noise_meter_value():
	var player_position = player.global_transform.origin
	var baby_position = baby.global_transform.origin 
	var distance = player_position.distance_to(baby_position)
	if distance > house_type.longest_distance:
		#global.noise_meter_value = 0
		noise_meter_value = 0
	else:
		noise_meter_value = int(104 - ((distance / house_type.longest_distance) * 100))	
	emit_signal("send_noise_value", noise_meter_value)
	

func _game_over_overlay():
	#print('game over')
	var game_over = get_tree().get_first_node_in_group("game_over")
	emit_signal("stop_player_movement", true)
	#print(game_over.name)
	game_over.visible = true
	
