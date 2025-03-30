extends Node2D

# Dicionário para guardar o estado de cada filho
var estados_filhos = {}
	
func _ready():
	ajustar_posicao()
	var viewport_size = get_viewport_rect().size
	position = Vector2(viewport_size.x / 2, -10)
	# Inicializa o estado para cada filho
	for filho in get_children():
		if filho is Node2D:
			estados_filhos[filho] = true  # Valor inicial de 'indo'

func ajustar_posicao():
	var viewport_size = get_viewport().get_visible_rect().size
	position = Vector2(viewport_size.x / 2, viewport_size.y / 5)

func _process(delta: float) -> void:
	ajustar_posicao()
	for filho in estados_filhos:
		var indo = estados_filhos[filho]
		
		if indo:
			filho.rotation_degrees -= 1 * delta
			if filho.rotation_degrees <= -5:
				estados_filhos[filho] = false
		else:
			filho.rotation_degrees += 1 * delta
			if filho.rotation_degrees >= 5:
				estados_filhos[filho] = true
