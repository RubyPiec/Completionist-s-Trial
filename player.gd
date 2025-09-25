extends CharacterBody2D

@onready var thecamera = $"../Camera2D"
@onready var audio = $"Jump"

@export var playerspeed = 300
@export var jumpheight = 650
@export var gravity = 25

var jumpsinrow = 0
var sidestepsinrow = 0
var konami = 0
signal out_of_view

func _physics_process(_delta):
	if(get_tree().current_scene.name=="Game"):
		Achievements.getAch("welcome")
		if !is_on_floor():
			velocity.y += gravity
			if velocity.y > 1000:
				velocity.y = 1000
				
		if Input.is_action_pressed("jump"):
			Achievements.getAch("jump")
			if is_on_floor():
				sidestepsinrow=0
				jumpsinrow = jumpsinrow+1
				if(jumpsinrow>=5):
					Achievements.getAch("excited")
				audio.play()
				velocity.y = -jumpheight
		
		if Input.is_action_just_pressed("jump"):
			if(konami<=1):
				konami+=1
			else:
				konami=0
				
		if Input.is_action_just_pressed("down"):
			if(konami==2||konami==3):
				konami+=1
			else:
				konami=0
			Achievements.getAch("notworking")
			
		if Input.is_action_just_pressed("move_left"):
			if(konami==4||konami==6):
				konami+=1
			else:
				konami=0
			Achievements.getAch("left")
			sidestepsinrow = sidestepsinrow+1
			if(sidestepsinrow>=5):
				Achievements.getAch("hold")
			jumpsinrow=0
		if Input.is_action_just_pressed("move_right"):
			if(konami==5||konami==7):
				konami+=1
				if(konami==8):
					Achievements.getAch("konami")
			else:
				konami=0
			Achievements.getAch("right")
			sidestepsinrow = sidestepsinrow+1
			if(sidestepsinrow>=5):
				Achievements.getAch("hold")
			jumpsinrow=0
			
		var horizontal_direction = Input.get_axis("move_left","move_right")
		
		if(position.x<(thecamera.position.x-576-64*0.7*0.555)):
			emit_signal("out_of_view", position)
		if(position.x>(thecamera.position.x+576+64*0.7*0.555)):
			emit_signal("out_of_view", position)
		if(position.y>(thecamera.position.y+324+64*0.7*0.555)):
			emit_signal("out_of_view", position)
		if(position.y<(thecamera.position.y-324-64*0.7*0.555)):
			emit_signal("out_of_view", position)
			
		velocity.x = playerspeed*horizontal_direction
		move_and_slide()

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_ceilings_area_entered(_area: Area2D) -> void: #this all looks ugly but oh well
	Achievements.getAch("ceiling")

func _on_area_2d_area_entered(_area: Area2D) -> void:
	Achievements.getAch("leftwall")

func _on_achievement_list_hider_area_entered(_area: Area2D) -> void:
	Achievements.getAch("myachievements")
	for ach in get_tree().current_scene.get_node("Camera2D/ScrollContainer/VBoxContainer").get_children():
		ach.color.a=0.2
		
func _on_achievement_list_hider_area_exited(_area: Area2D) -> void:
	for ach in get_tree().current_scene.get_node("Camera2D/ScrollContainer/VBoxContainer").get_children():
		ach.color.a=1
