extends CharacterBody2D

@onready var thecamera = $"../Camera2D"
@onready var audio = $"../AudioStreamPlayer2D"

@export var playerspeed = 300
@export var jumpheight = 650
@export var gravity = 25

signal out_of_view

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
			
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			audio.play()
			velocity.y = -jumpheight
	
	var horizontal_direction = Input.get_axis("move_left","move_right")
	
	if(position.x<(thecamera.position.x-576-64*0.7*0.555)):
		emit_signal("out_of_view", position)
	if(position.x>(thecamera.position.x+576+64*0.7*0.555)):
		emit_signal("out_of_view", position)
	if(position.y>(thecamera.position.y+324+64*0.7*0.555)):
		emit_signal("out_of_view", position)
	if(position.y>(thecamera.position.y-324-64*0.7*0.555)):
		emit_signal("out_of_view", position)
		
	velocity.x = playerspeed*horizontal_direction
	move_and_slide()

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func get_animated_sprite_2d_size() -> Vector2:
	return animated_sprite_2d.sprite_frames.get_frame_texture(animated_sprite_2d.animation, animated_sprite_2d.frame).get_size()
