extends Control

var currMinutes : int
var currSeconds : int

@export var startMinutes = 0
@export var startSeconds = 0

signal time_over
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_timer()
	if currSeconds < 10:
		$HBoxContainer/TimerLabel.text = str(currMinutes) + ":0" + str(currSeconds)
	else: $HBoxContainer/TimerLabel.text = str(currMinutes) + ":" + str(currSeconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clock_arrow_rotate(delta)
	var powerups = get_tree().get_nodes_in_group("powerups")
	for powerup in powerups:
		powerup.connect("TimePowerUpActivate" , self._time_powerup_activated)


func _on_timer_timeout() -> void:
	if currMinutes == 0 && currSeconds == 0:
		print('test')
		emit_signal("time_over")
		currSeconds = 1
	elif currMinutes > 0:
		if currSeconds == 0:
			if currMinutes > 0:
				currMinutes -= 1
				currSeconds = 60
	currSeconds -= 1
	
	if currSeconds < 10:
		$HBoxContainer/TimerLabel.text = str(currMinutes) + ":0" + str(currSeconds)
	else: $HBoxContainer/TimerLabel.text = str(currMinutes) + ":" + str(currSeconds)
	
func _time_powerup_activated():

	var totSeconds = (currMinutes * 60) + currSeconds + 30
	
	currSeconds = totSeconds % 60
	currMinutes = totSeconds / 60
# Starts clock arrow rotation
func clock_arrow_rotate(delta):
	var totSeconds = (startMinutes * 60) + startSeconds
	var rotationInc = PI / totSeconds
	if $Arrow.rotation < PI:
		$Arrow.rotation += rotationInc * delta

# Make sure timmer starts at desired time every time scene loads
func reset_timer():
	currSeconds = startSeconds
	currMinutes = startMinutes
