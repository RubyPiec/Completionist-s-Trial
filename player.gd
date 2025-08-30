extends CharacterBody2D

@export var playerspeed = 300
@export var jumpheight = 650
@export var gravity = 25


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
			
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -jumpheight
	
	var horizontal_direction = Input.get_axis("move_left","move_right")
	
	velocity.x = playerspeed*horizontal_direction
	
	move_and_slide()
