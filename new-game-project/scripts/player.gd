extends CharacterBody2D

@export var speed := 150
@onready var animations = $AnimationPlayer
var ydirection = "Down"
var xdirection = "Right"

const DASH_SPEED = 275
var dashing = false
var can_dash = true
var can_move = true
var level_entered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var house_doors = get_tree().get_nodes_in_group("house_doors")
	# house_doors will be empty upon entering any level because new tree node
	if house_doors.is_empty():
		print('door')
		level_entered = true
		
	if level_entered:
		print("level entered")
		var houses = get_tree().get_nodes_in_group("house")
		for house in houses:
			house.connect("stop_player_movement", self._stop_movement_flag)
	
	if (can_move):
		var direction = Input.get_vector("left", "right", "up", "down")
		if Input.is_action_just_pressed("dash") and can_dash:
			dashing = true
			can_dash = false
			$DashTimer.start()
			$CanDashTimer.start()
			
		if dashing:
			velocity = direction * DASH_SPEED
		else: 
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
	print(flag)
	can_move = false

func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_can_dash_timer_timeout() -> void:
	can_dash = true
