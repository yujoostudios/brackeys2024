extends Node2D

@onready var baby = $Furniture/BabyAndCrib
@onready var player = $Player
var longest_distance = 2151
var noise_meter_value = 0

signal send_noise_value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	calc_noise_meter_value()
	emit_signal("send_noise_value", noise_meter_value)

# Calculate the current distance between player and baby
func calc_noise_meter_value():
	var player_position = player.global_transform.origin
	var baby_position = baby.global_transform.origin 
	var distance = player_position.distance_to(baby_position)
	
	if distance > longest_distance:
		#global.noise_meter_value = 0
		noise_meter_value = 0
	else:
		noise_meter_value = int(104 - ((distance / longest_distance) * 100))	
	emit_signal("send_noise_value", noise_meter_value)
		
