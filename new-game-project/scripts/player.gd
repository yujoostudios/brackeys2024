extends CharacterBody2D

@export var speed := 100
@onready var animations = $AnimationPlayer
var ydirection = "Down"
var xdirection = "Right"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
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
	else: animations.play("Walk" + ydirection + xdirection)
