extends Control

var selected_words = [{"letters": [], "miss": false, "letter_value": 100}, 
{"letters": [], "miss": false, "letter_value": 100},
{"letters": [], "miss": false, "letter_value": 100},
{"letters": [], "miss": false, "letter_value": 100}]
var word_images = []  # Armazenará as imagens das palavras

var fourl_words = [
	{"image": "res://assets/vetores/casa.png", "word": "CASA"},
	{"image": "res://assets/vetores/sino.png", "word": "SINO"},
	{"image": "res://assets/vetores/cama.png", "word": "CAMA"},
	{"image": "res://assets/vetores/bola.png", "word": "BOLA"},
	{"image": "res://assets/vetores/foca.png", "word": "FOCA"},
	{"image": "res://assets/vetores/lixo.png", "word": "LIXO"},
	{"image": "res://assets/vetores/urso.png", "word": "URSO"},
	{"image": "res://assets/vetores/pato.png", "word": "PATO"},
	{"image": "res://assets/vetores/rato.png", "word": "RATO"},
	{"image": "res://assets/vetores/pipa.png", "word": "PIPA"},
] # 10 palavras com imagens

var fivel_words = [
	{"image": "res://assets/vetores/apito.png", "word": "APITO"},
	{"image": "res://assets/vetores/pente.png", "word": "PENTE"},
	{"image": "res://assets/vetores/livro.png", "word": "LIVRO"},
	{"image": "res://assets/vetores/lapis.png", "word": "LAPIS"},
	{"image": "res://assets/vetores/jarra.png", "word": "JARRA"},
	{"image": "res://assets/vetores/piano.png", "word": "PIANO"},
	{"image": "res://assets/vetores/porta.png", "word": "PORTA"},
	{"image": "res://assets/vetores/chave.png", "word": "CHAVE"},
	{"image": "res://assets/vetores/pedra.png", "word": "PEDRA"},
	{"image": "res://assets/vetores/cobra.png", "word": "COBRA"},
	{"image": "res://assets/vetores/zebra.png", "word": "ZEBRA"},
]

var sixl_words = [
	{"image": "res://assets/vetores/colher.png", "word": "COLHER"},
	{"image": "res://assets/vetores/sapato.png", "word": "SAPATO"},
	{"image": "res://assets/vetores/boneca.png", "word": "BONECA"},
	{"image": "res://assets/vetores/tijolo.png", "word": "TIJOLO"},
	{"image": "res://assets/vetores/panela.png", "word": "PANELA"},
	{"image": "res://assets/vetores/abajur.png", "word": "ABAJUR"},
	{"image": "res://assets/vetores/girafa.png", "word": "GIRAFA"},
	{"image": "res://assets/vetores/cavalo.png", "word": "CAVALO"},
	{"image": "res://assets/vetores/macaco.png", "word": "MACACO"},
	{"image": "res://assets/vetores/banana.png", "word": "BANANA"},
	{"image": "res://assets/vetores/tomate.png", "word": "TOMATE"},
]

func set_gaps(array_size: int) -> void:
	var x = 120
	var y_positions = [80, 180, 80, 180]  # Posições Y para cada linha
	var image_offset = Vector2(-40, -50)  # Ajuste de posição da imagem
	var words
	
	if array_size == 4:
		words = fourl_words
	elif array_size == 5:
		words = fivel_words
	else:
		words = sixl_words
	
	# Limpa imagens anteriores
	for img in word_images:
		img.queue_free()
	word_images.clear()
	
	# Seleção de palavras
	var selected_indices = []
	while selected_indices.size() < 4:
		var idx = randi() % words.size()
		if not selected_indices.has(idx):
			selected_indices.append(idx)
	
	# Criação dos elementos
	for i in 4:
		if i == 2:
			match array_size:
				4:
					x += 700
				5:
					x += 620
				_:
					x += 560
		var word_data = words[selected_indices[i]]
		var word_str = word_data["word"]
		
		# Adiciona imagem da palavra
		if word_data["image"] != "":
			var img = TextureRect.new()
			img.texture = load(word_data["image"])
			img.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			img.custom_minimum_size = Vector2(128, 128)
			add_child(img)
			word_images.append(img)
			img.position = Vector2(x - 125, y_positions[i] + image_offset.y + 20)
		
		# Criação das letras
		for n in array_size:
			var draggable = get_node("Arrastável").duplicate()
			selected_words[i]["letters"].append([draggable, word_str[n]])
			add_child(draggable)
			draggable.position = Vector2(x + (n * 75), y_positions[i])

func verify_gaps() ->bool:
	var completed = true
	for w in selected_words:
		var letters = w["letters"]
		for l in letters:
			if not(l[0].is_occupied):
				completed = false
				break
	return completed

func _ready() -> void:
	set_gaps(Jogo.word_size)
