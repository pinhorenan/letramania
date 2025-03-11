extends Control

var first_word = []
var second_word = []
var third_word = []

var words = [
	{"image": "", "word": "CASA"},
	{"image": "", "word": "SINO"},
	{"image": "", "word": "CAMA"},
	{"image": "", "word": "BOLA"},
	{"image": "", "word": "FOCA"},
	{"image": "", "word": "LIXO"},
	{"image": "", "word": "URSO"},
	{"image": "", "word": "PATO"},
	{"image": "", "word": "RATO"},
	{"image": "", "word": "PIPA"},
] # 10 palavras no momento

# IDEIA INICIAL: Fazer cada letra ser um array com a respectiva área e caractere
# Talvez incluir o caminho até a respectiva imagem da palavra como primeiro elemento do array (tendo uma posição conhecida a gente poderia evitar de criar outro dicionário)
func set_gaps(array_size: int) -> void: # Criação dos espaços para as palavras com as respectivas letras
	
# Essas palavras serão usadas momentâneamente. 
	var x = 180
	var random_number = randi() % 10 # Gera um número aleatório para usar de índice na lista de palavras
	var previous_random_number = random_number # Mesma coisa que o anterior, mas para as palavras subsequentes
	var ante_previous_random_number
	var first_word_str
	var second_word_str
	var third_word_str
	
	first_word_str = words[random_number]["word"]

	while true: # Loop para checar se não é uma palavra igual a anterior
		random_number = randi() % 10
		if random_number != previous_random_number:
			second_word_str = words[random_number]["word"]
			ante_previous_random_number = previous_random_number
			previous_random_number = random_number
			break
	
	while true:
		random_number = randi() % 10
		if random_number != previous_random_number:
			if random_number != ante_previous_random_number:
				third_word_str = words[random_number]["word"]
				break
	# NOTA: Talvez fazer um try-catch/except pras palavras das fases subsequentes. Isso evitaria a necessidade de "limpar" a tela toda vez que o jogador passasse de fase.
	for n in array_size: # Cada letra é um array com dois elementos. 0 = Área, 1 = Caractere
		first_word.append([get_node("Arrastável").duplicate(), first_word_str[n]])
		add_child(first_word[n][0])
		first_word[n][0].position = Vector2(x, 60)		
		second_word.append([get_node("Arrastável").duplicate(), second_word_str[n]])
		add_child(second_word[n][0])
		second_word[n][0].position = Vector2(x, 160)
		third_word.append([get_node("Arrastável").duplicate(), third_word_str[n]])
		add_child(third_word[n][0])
		third_word[n][0].position = Vector2(x, 260)
		x += 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_gaps(4) # Chamada de teste para colocar as caixas na tela.
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
