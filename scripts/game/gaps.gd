extends Control

var selected_words = [[], [], [], []]
var word_images = []  # Armazenará as imagens das palavras

var fourl_words = [
	{"image": "res://recursos/vetores/casa.png", "word": "CASA"},
	{"image": "res://recursos/vetores/sino.png", "word": "SINO"},
	{"image": "res://recursos/vetores/cama.png", "word": "CAMA"},
	{"image": "res://recursos/vetores/bola.png", "word": "BOLA"},
	{"image": "res://recursos/vetores/foca.png", "word": "FOCA"},
	{"image": "res://recursos/vetores/lixo.png", "word": "LIXO"},
	{"image": "res://recursos/vetores/urso.png", "word": "URSO"},
	{"image": "res://recursos/vetores/pato.png", "word": "PATO"},
	{"image": "res://recursos/vetores/rato.png", "word": "RATO"},
	{"image": "res://recursos/vetores/pipa.png", "word": "PIPA"},
] # 10 palavras com imagens

var fivel_words = [
	{"image": "", "word": "APITO"},
	{"image": "", "word": "PENTE"},
	{"image": "", "word": "LIVRO"},
	{"image": "", "word": "LAPIS"},
	{"image": "", "word": "JARRA"},
	{"image": "", "word": "PIANO"},
	{"image": "", "word": "PORTA"},
	{"image": "", "word": "CHAVE"},
	{"image": "", "word": "PEDRA"},
	{"image": "", "word": "COBRA"},
	{"image": "", "word": "ZEBRA"},
]

var sixl_words = [
	{"image": "", "word": "COLHER"},
	{"image": "", "word": "SAPATO"},
	{"image": "", "word": "BONECA"},
	{"image": "", "word": "TIJOLO"},
	{"image": "", "word": "PANELA"},
	{"image": "", "word": "ABAJUR"},
	{"image": "", "word": "GIRAFA"},
	{"image": "", "word": "CAVALO"},
	{"image": "", "word": "MACACO"},
	{"image": "", "word": "BANANA"},
	{"image": "", "word": "TOMATE"},
]

func set_gaps(array_size: int) -> void:
	var x = 110
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
					x += 540
		var word_data = words[selected_indices[i]]
		var word_str = word_data["word"]
		print(words[selected_indices[i]])
		
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
			selected_words[i].append([draggable, word_str[n]])
			add_child(draggable)
			draggable.position = Vector2(x + (n * 80), y_positions[i])

func verify_gaps() ->bool:
	var completed = true
	for w in selected_words:
		for l in w:
			if not(l[0].is_occupied):
				completed = false
				break
	return completed

func _ready() -> void:
	var completed = false
	set_gaps(Jogo.word_size)
