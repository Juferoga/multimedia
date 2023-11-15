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
		if file.open(path, File.READ) == OK:
			var contents = file.get_as_text()
			file.close()
			var parsed_achievements = JSON.parse(contents)
			if parsed_achievements is Dictionary:
				achievements = parsed_achievements
				print("Logros cargados correctamente")
			else:
				print("Error: Contenido no es un diccionario")
		else:
			print("Error al abrir el archivo")
	else:
		print("El archivo no existe")
		saveAchievements()  # Crea un archivo nuevo si no existe

func unlockAchievement(name: String):
	loadAchievements()  # Carga los logros actuales
	achievements[name] = true  # Actualiza el logro desbloqueado
	saveAchievements()  # Guarda los logros actualizados

func hasAchievement(name: String) -> bool:
	return achievements.has(name) and achievements[name] == true

func printAchievementStatus(name: String):
	if hasAchievement(name):
		print(name + ": Conseguido")
	else:
		print(name + ": No conseguido")
