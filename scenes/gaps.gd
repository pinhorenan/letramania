extends Control

var first_word = []
var second_word = []
var third_word = []
const separator = 3

# IDEIA INICIAL: Fazer cada letra ser um array com a respectiva área e caractere
# Talvez incluir o caminho até a respectiva imagem da palavra como primeiro elemento do array (tendo uma posição conhecida a gente poderia evitar de criar outro dicionário)
func set_gaps(array_size: int) -> void: # Criação dos espaços para as palavras com as respectivas letras
	
# Essas palavras serão usadas momentâneamente. 
	var first_example = "CASAS"
	var second_example = "SINOS"
	var third_example = "CAMAS"
	var x = 120
	
	for n in array_size: # Cada letra é um array com dois elementos. 0 = Área, 1 = Caractere
		first_word.append([get_node("Arrastável").duplicate(), first_example[n]])
		add_child(first_word[n][0])
		first_word[n][0].position = Vector2(x, 60)
		second_word.append([get_node("Arrastável").duplicate(), second_example[n]])
		add_child(second_word[n][0])
		second_word[n][0].position = Vector2(x, 160)
		third_word.append([get_node("Arrastável").duplicate(), third_example[n]])
		add_child(third_word[n][0])
		third_word[n][0].position = Vector2(x, 260)
		x += 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_gaps(5)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
