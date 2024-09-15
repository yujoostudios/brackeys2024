extends CharacterBody2D

@export var speed := 150
@export var dashnoise = 0
@export var walknoise = 0
@export var standnoise = 0
@onready var animations = $AnimationPlayer
var ydirection = "Down"
var xdirection = "Right"
var speedPowerUpActivated = false

var dash_speed = 275
var dashing = false
var can_dash = true
var can_move = true
var level_entered = false

signal dash_noise
signal walk_noise
signal stand_noise
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var house_doors = get_tree().get_nodes_in_group("house_doors")
	# house_doors will be empty upon entering any level because new tree node
	if house_doors.is_empty():
		#print('door')
		level_entered = true
		
	if level_entered:
		#print("level entered")
		var houses = get_tree().get_nodes_in_group("house")
		for house in houses:
			house.connect("stop_player_movement", self._stop_movement_flag)
			
	var powerups = get_tree().get_nodes_in_group("powerups")
	for powerup in powerups:
		powerup.connect("SpeedPowerUpActivate", self._speed_powerup_activated)
	
	if (can_move):
		var direction = Input.get_vector("left", "right", "up", "down")
		if Input.is_action_just_pressed("dash") and can_dash:
			dashing = true
			can_dash = false
			$DashTimer.start()
			$CanDashTimer.start()
			
		if dashing:
			velocity = direction * dash_speed
		else: 
			$DashTimer.stop()
			#print(direction.is_zero_approx())
			if direction.is_zero_approx() == false:		
				$StandTimer.start()
			else:
				$WalkTimer.start()
			velocity = direction * speed
		move_and_slide()
		updateAnimation()
	else:
		pass
	
func updateAnimation():

	if velocity.x < 0: xdirection = "Left"
	elif velocity.x > 0: xdirection = "Right"
	
	if velocity.y < 0: ydirection = "Up"
	elif velocity.y > 0: ydirection = "Down"
	
	if velocity.length() == 0:
		animations.play("Idle" + ydirection + xdirection)
	elif dashing: 
		animations.play("Dash" + ydirection + xdirection)
	else:
		animations.play("Walk" + ydirection + xdirection)
		
func _stop_movement_flag(flag : bool):
	#print(flag)
	can_move = false

func _on_dash_timer_timeout() -> void:
	#print('dashed')
	emit_signal("dash_noise", dashnoise)
	dashing = false

func _on_can_dash_timer_timeout() -> void:
	can_dash = true
	
	
func _speed_powerup_activated():
	$SpeedPowerUpTimer.start()
	speedPowerUpActivated = true
	dash_speed += 200
	speed += 200
	
func _on_speed_power_up_timer_timeout() -> void:
	speedPowerUpActivated = false
	dash_speed -= 200
	speed -= 200
	$SpeedPowerUpTimer.stop()


func _on_walk_timer_timeout() -> void:
	emit_signal("walk_noise", walknoise)


func _on_stand_timer_timeout() -> void:
	emit_signal("stand_noise" , standnoise)
