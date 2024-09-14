extends CharacterBody2D

@export var speed := 150
@onready var animations = $AnimationPlayer
var ydirection = "Down"
var xdirection = "Right"

const DASH_SPEED = 275
var dashing = false
var can_dash = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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

func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_can_dash_timer_timeout() -> void:
	can_dash = true
