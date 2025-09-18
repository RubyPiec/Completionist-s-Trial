extends Node2D

# ID: [Name, Description, Obtained]
var achievements = {
	"welcome": ["Welcome!", "Hit the 'Play' button", false],
	"jump": ["Jump", "Hit the jump key", false],
	"excited": ["Excited?", "Jump 5 times in a row", false],
	"right": ["Right is always right!", "Go right", false],
	"left": ["Time to leave", "Go left", false],
	"hold": ["You can hold...", "Hit left or right 5 times in a row", false],
	"notworking": ["That won't work...", "Try to go down", false],
	"changescreen": ["Ooh, what's here?", "Go to a different screen", false],
	"konami": ["+30 Lives!", "You already had infinite...", false]
}

func getAch(code):
	if(!achievements[code][2]):
		var achget = get_tree().get_first_node_in_group("Player").find_child("Achget")
		achievements[code][2]=true
		achget.play()
		updColors()

func updColors():
	if(get_tree().current_scene.name=="Game"):
		for ach in achievements:
			if(achievements[ach][2]==true):
				get_tree().current_scene.get_node("Camera2D/ScrollContainer/VBoxContainer/"+ach+"/Achievement/AchDesc").text=achievements[ach][1]
				get_tree().current_scene.get_node("Camera2D/ScrollContainer/VBoxContainer/"+ach).color=Color("#11cc11")
