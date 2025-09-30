extends CharacterBody2D

@onready var thecamera = $"../Camera2D"
@onready var audio = $"Jump"


@onready var inHouse = false
@onready var timeInHouse = 0

@export var playerspeed = 300
@export var jumpheight = 650
@export var gravity = 25

var jumpsinrow = 0
var sidestepsinrow = 0
var konami = 0
var deaths = 0
var deathcd = 0
signal out_of_view

func die():
	self.position.x=47
	self.position.y=300
	if Input.is_action_pressed("jump"):
		Achievements.getAch("physics") #this is just how im hardcoding it
	if deathcd <= 0:
		deathcd = 0.5
		deaths += 1
		Achievements.getAch("death")
		if deaths==10:
			Achievements.getAch("retry")
		if deaths==25:
			Achievements.getAch("viciousloop")
	
func _physics_process(delta):
	deathcd -= delta
	if inHouse:
		timeInHouse=timeInHouse+delta
		if timeInHouse > 5:
			Achievements.getAch("enjoyment")
	else:
		timeInHouse=0
	if(get_tree().current_scene.name=="Game"):
		Achievements.getAch("welcome")
		if !is_on_floor():
			velocity.y += gravity
			if velocity.y > 1000:
				velocity.y = 1000
				
		if Input.is_action_pressed("jump"): #Down is optional
			if Input.is_action_pressed("move_left"):
				if Input.is_action_pressed("move_right"):
					Achievements.getAch("screenshot")
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
		
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			
			if collider==$"../extratiles":
				die() # cant make only spikes kill you... grr

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

func _on_house_area_entered(area: Area2D) -> void:
	Achievements.getAch("homesweethome")
	inHouse = true

func _on_house_area_exited(area: Area2D) -> void:
	inHouse = false

func _on_secret_area_entered(area: Area2D) -> void:
	Achievements.getAch("secret")

func _on_floor_2_area_entered(area: Area2D) -> void:
	Achievements.getAch("morecontent")

func _on_wrongway_area_entered(area: Area2D) -> void:
	Achievements.getAch("wrongway")
