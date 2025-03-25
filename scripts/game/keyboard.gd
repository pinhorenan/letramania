extends Control

var alphabet = ["A","B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q",
"R", "S", "T", "U", "V", "W", "X", "Y", "Z"] # Provavelmente há solução melhor mas vai ser isso por enquanto.
var key_list = []
var tip_timeout = 3000

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

	while len(key_list) != 30: # NOTA: Do jeito que está, existe uma chance (bem pequena) de criar cenários estranhos onde, por exemplo, uma única letra se repetiria por todas as opções
		idx = rng.randi_range(0, 25)
		letter_name = alphabet[idx]
		letter_node = get_node(letters_parent_path + letter_name).duplicate()
		add_child(letter_node)
		letter_node.letter_name = letter_name
		key_list.append(letter_node) # adicionando letras aleatórias

		
	key_list.shuffle()
	
	for l in key_list: # Posicionamento das letras disponíveis
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

func tip_letter(letter, type):
	for key in key_list:
		if key && key.letter_name == letter:
			var path = "res://recursos/letras/" + letter.to_lower() 
			if type == 1:
				var new_icon = load(path + "tip.png")  
				key.icon = new_icon 
			else:
				var new_icon = load(path + ".png") 
				key.icon = new_icon
			break  
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
