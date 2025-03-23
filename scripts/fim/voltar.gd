extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_inicio_pressed() -> void:
	Jogo.word_size = 3 # Voltando para a primeira fase
	Jogo.tempo_decorrido = 0.0 # Resetando temporizador
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
