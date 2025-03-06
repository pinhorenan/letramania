extends Node2D

# Dicionário para guardar o estado de cada filho
var estados_filhos = {}

func _ready():
	# Inicializa o estado para cada filho
	for filho in get_children():
		if filho is Node2D:
			estados_filhos[filho] = true  # Valor inicial de 'indo'

func _process(delta: float) -> void:
	for filho in estados_filhos:
		var indo = estados_filhos[filho]
		
		if indo:
			filho.rotation_degrees -= 1 * delta
			if filho.rotation_degrees <= -3:
				estados_filhos[filho] = false
		else:
			filho.rotation_degrees += 1 * delta
			if filho.rotation_degrees >= 3:
				estados_filhos[filho] = true
