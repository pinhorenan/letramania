extends Control

var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q",
"R", "S", "T", "U", "V", "W", "X", "Y", "Z"] # Provavelmente há solução melhor mas vai ser isso por enquanto.
var key_list = []

func spawn_keys(word_list) -> void:
	var rng = RandomNumberGenerator.new();
	var idx # variável que receberá os indíces gerados aleatoriamente
	var letter_name
	var letter_node
	var x = 175
	var y = 370
	var letters_parent_path = "/root/Node2D/Control/Letras/"
	rng.randomize()
	
	for word in word_list:
		for l in word: # fazendo a busca de cada letra em cada palavra
			letter_name = l[1]
			letter_node = get_node(letters_parent_path + letter_name).duplicate()
			add_child(letter_node)
			letter_node.letter_name = letter_name
			key_list.append(letter_node) # adicionando à lista de letras do teclado que será gerado futuramente
	
	while len(key_list) != 30:
		idx = rng.randi_range(0, 25)
		letter_name = alphabet[idx]
		letter_node = get_node(letters_parent_path + letter_name).duplicate()
		add_child(letter_node)
		letter_node.letter_name = letter_name
		key_list.append(letter_node) # adicionando letras aleatórias
	
	for l in key_list:
		print(l)
	key_list.shuffle()
	for l in key_list:
		print(l)
	
	for l in key_list:
		if x == 975:
			x = 175
			y += 80
		l.position = Vector2(x, y)
		l.original_position = l.position
		x += 80
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	var lacunas = get_node("/root/Node2D/Control/Lacunas")
	spawn_keys(lacunas.selected_words)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
