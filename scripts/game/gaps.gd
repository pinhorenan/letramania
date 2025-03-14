extends Control

var selected_words = [[], [], []]
var word_images = []  # Armazenará as imagens das palavras

var words = [
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

func set_gaps(array_size: int) -> void:
	var x = 180
	var y_positions = [60, 160, 260]  # Posições Y para cada linha
	var image_offset = Vector2(-40, -50)  # Ajuste de posição da imagem
	
	# Limpa imagens anteriores
	for img in word_images:
		img.queue_free()
	word_images.clear()
	
	# Seleção de palavras
	var selected_indices = []
	while selected_indices.size() < 3:
		var idx = randi() % words.size()
		if not selected_indices.has(idx):
			selected_indices.append(idx)
	
	# Criação dos elementos
	for i in 3:
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
			selected_words[i].append([draggable, word_str[n]])
			add_child(draggable)
			draggable.position = Vector2(x + (n * 80), y_positions[i])
		
		print("Palavra ", i + 1, ": ", word_str, " | Imagem: ", word_data["image"])

func _ready() -> void:
	set_gaps(4)
