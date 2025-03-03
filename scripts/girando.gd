extends Sprite2D

var indo = true  # Correção: Não precisa de "bool" explícito

func _process(delta: float) -> void:
	if indo:
		rotation_degrees -= 1 * delta  # Movimento mais perceptível
		if rotation_degrees <= -3:  # Quando atinge -3, inverte
			indo = false
	else:
		rotation_degrees += 1 * delta  # Movimento na outra direção
		if rotation_degrees >= 3:  # Quando atinge 3, inverte
			indo = true
