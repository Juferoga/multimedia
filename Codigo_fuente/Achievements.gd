extends Node

var path = "user://achievements.json"
var achievements = {
	"no_hit": false,
	"all_lifes": false,
	"hell_king": false
}

func _ready():
	loadAchievements()

func saveAchievements():
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(to_json(achievements))
	file.close()

func loadAchievements():
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var contents = file.get_as_text()
		file.close()
		achievements = parse_json(contents)
		if typeof(achievements) != typeof({}):
			resetAchievements()

func resetAchievements():
	achievements = {
		"no_hit": false,
		"all_lifes": false,
		"hell_king": false
	}

func unlockAchievement(name: String):
	if achievements.has(name) and typeof(achievements[name]) == typeof(true):
		achievements[name] = true
		saveAchievements()

func hasAchievement(name: String) -> bool:
	return achievements.has(name) and achievements[name] == true

func printAchievementStatus(name: String):
	if hasAchievement(name):
		print(name + ": Conseguido")
	else:
		print(name + ": No conseguido")

