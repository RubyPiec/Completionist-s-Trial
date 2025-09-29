extends Node2D

# ID: [Name, Description, Obtained]
var achievements = {
	"welcome": ["Welcome!", "Hit the 'Play' button", false],
	"jump": ["Jump", "Hit the jump key", false],
	"excited": ["Excited?", "Jump 5 times in a row", false],
	"right": ["Right is always right!", "Go right", false],
	"left": ["Time to leave", "Go left", false],
	"screenshot": ["Screenshot taken", "Hit every key at once", false],
	"hold": ["You can hold...", "Hit left or right 5 times in a row", false],
	"notworking": ["That won't work...", "Try to go down", false],
	"clicker": ["Ow!", "Click the player", false],
	"stop": ["Stop that!", "Click the player 5 times", false],
	"ceiling": ["My head!", "Hit a ceiling", false],
	"changescreen": ["Ooh, what's here?", "Go to a different screen", false],
	"leftwall": ["The farlands", "Touch the left wall", false],
	"homesweethome": ["Home Sweet Home", "Enter your house", false],
	"enjoyment": ["Truly my home", "Stay in your house for 5 seconds", false],
	"myachievements": ["Fading achievements", "Touch the achievement list", false],
	"konami": ["+30 Lives!", "You already had infinite...", false]
}

func getAch(code):
	if(!achievements[code][2]):
		var achget = get_tree().get_first_node_in_group("Player").find_child("Achget")
		achievements[code][2]=true
		achget.play()
		if(get_tree().current_scene.name=="Game"):
			var justGotAch = get_tree().current_scene.get_node("Camera2D/ScrollContainer/VBoxContainer/"+code)
			var hhhh = justGotAch.duplicate() #what do i name this variable even
			hhhh.color=Color("#11cc11")
			hhhh.get_child(0).get_child(1).text=achievements[code][1]
			get_tree().current_scene.get_node("Camera2D/RecentAchs").add_child(hhhh)
			var tween = get_tree().create_tween()
			tween.connect("finished",func(): hhhh.queue_free())
			tween.tween_property(get_tree().current_scene.get_node("Camera2D/RecentAchs/"+code),"modulate:a",0,2)
		updColors()

func updColors():
	if(get_tree().current_scene.name=="Game"):
		for ach in achievements:
			if(achievements[ach][2]==true):
				get_tree().current_scene.get_node("Camera2D/ScrollContainer/VBoxContainer/"+ach+"/Achievement/AchDesc").text=achievements[ach][1]
				var achrect = get_tree().current_scene.get_node("Camera2D/ScrollContainer/VBoxContainer/"+ach)
				achrect.color=Color(17.0/255.0, 204.0/255.0, 17.0/255.0, achrect.color.a)
