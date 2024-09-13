extends Control

var currMinutes
var currSeconds

var startMinutes = 1
var startSeconds = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_timer()
	if currSeconds < 10:
		$HBoxContainer/TimerLabel.text = str(currMinutes) + ":0" + str(currSeconds)
	else: $HBoxContainer/TimerLabel.text = str(currMinutes) + ":" + str(currSeconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clock_arrow_rotate(delta)


func _on_timer_timeout() -> void:
	if currMinutes == 0 && currSeconds == 0:
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
