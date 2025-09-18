extends ScrollContainer

@onready var baseNode = $"VBoxContainer/welcome"

func _ready() -> void:
	for achievement in Achievements.achievements:
		var cachievement = Achievements.achievements[achievement] # what the hell is this code
		if(achievement!='welcome'):
			var newach = baseNode.duplicate()
			newach.name = achievement
			newach.get_node("Achievement/AchName").text=cachievement[0] # c stands for current
			newach.get_node("Achievement/AchDesc").text="???"
			baseNode.get_parent().add_child(newach)
