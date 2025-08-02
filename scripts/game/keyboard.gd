extends Control

var outline_shader := preload("res://shaders/outline.gdshader")
var alphabet = ["A","B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q",
"R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
var key_list = []
var tip_timeout = 3000
var material_cache := {}

func spawn_keys(word_list) -> void:
	var rng = RandomNumberGenerator.new();
	rng.randomize()

	# adiciona as letras necessárias p/ palavras chaves
	for word in word_list:
		for l in word["letters"]:
			var letter_name = l[1]
			var template = get_node(letter_name)
			var letter_node = template.duplicate()
			add_child(letter_node)
			letter_node.letter_name = letter_name
			key_list.append(letter_node)

	# completa com outras letras aleatórias
	while key_list.size() < 30:
		var idx = rng.randi_range(0, alphabet.size() - 1)
		var letter_name = alphabet[idx]
		var template = get_node(letter_name)
		var letter_node = template.duplicate()
		add_child(letter_node)
		letter_node.letter_name = letter_name
		key_list.append(letter_node)
		
	key_list.shuffle()
	
	# posiciona no grid
	var x = 204
	var y = 370
	for l in key_list:
		if x == 954:
			x = 204
			y += 75
		l.position = Vector2(x, y)
		l.original_position = l.position
		x += 75
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	var lacunas = get_node("/root/Node2D/Control/Lacunas")
	spawn_keys(lacunas.selected_words)
	
func tip_letter(letter: String, type: int) -> void:
        for key in key_list:
                if is_instance_valid(key) and key.letter_name == letter:
                        if type == 1:
                                # aplica material shader de bordinhas verdes <3
                                if not material_cache.has(key):
                                        var mat := ShaderMaterial.new()
                                        mat.shader = outline_shader
                                        material_cache[key] = mat
                                key.material = material_cache[key]
                        else:
                                # nao
                                key.material = null
                                material_cache.erase(key)
                        break
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
