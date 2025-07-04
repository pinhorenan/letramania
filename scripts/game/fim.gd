extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Jogo.time_end = Jogo.get_time()
	Jogo.calcular_media()
	Jogo.salvar_dados_no_csv()
	$Background.texture = load("res://assets/menu/background_" + Configuracoes.nome_tema + ".png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_inicio_pressed() -> void:
	Jogo.word_size = 3 # Voltando para a primeira fase
	Jogo.tempo_decorrido = 0.0 # Resetando temporizador
	Jogo.vidas = Configuracoes.config["vidas"]
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
