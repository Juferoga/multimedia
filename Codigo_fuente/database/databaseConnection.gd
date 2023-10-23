extends Node

# Declaramos una variable para la conexión SQLite
var db = null

func _ready():
	# Inicializamos la conexión con la base de datos
	db = SQLite.new()
	db.open("user://mi_base_de_datos.db")
	
	# Creamos una tabla si no existe
	db.query("CREATE TABLE IF NOT EXISTS usuarios (id INTEGER PRIMARY KEY, nombre TEXT, edad INTEGER);")
	
	# Insertamos algunos datos
	insertar_datos("Juan", 25)
	insertar_datos("Ana", 30)
	
	# Leemos los datos
	leer_datos()
	
	# Cerramos la base de datos
	db.close()

# Función para insertar datos
func insertar_datos(nombre: String, edad: int):
	db.query("INSERT INTO usuarios (nombre, edad) VALUES ('" + nombre + "', " + str(edad) + ");")

# Función para leer datos
func leer_datos():
	var resultado = db.query("SELECT * FROM usuarios;")
	while resultado.step() == SQLite.RESULT_ROW:
		print("ID: ", resultado.column_int(0))
		print("Nombre: ", resultado.column_text(1))
		print("Edad: ", resultado.column_int(2))
