extends Button

var is_dragging := false
var offset := Vector2()
var original_position := Vector2()
var current_snap_area: Node = null
var current_snap_area_letter
var is_snapped := false  # Indica se a letra está encaixada
var letter_name
var completed = false
@onready var lacunas = get_node("/root/Node2D/Control/Lacunas")

func _ready():
	pass

func _gui_input(event: InputEvent) -> void:
	#<<<<<<< HEAD
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:  # Botão pressionado
			if is_snapped:
				# Se a letra já está encaixada, permita movê-la novamente
				current_snap_area.is_occupied = false
				current_snap_area.modulate.a = 1.0  # Resetar opacidade
				current_snap_area = null
				is_snapped = false
			is_dragging = true
			offset = get_local_mouse_position()
		else:  # Botão solto
			is_dragging = false
			if current_snap_area and not current_snap_area.is_occupied and current_snap_area_letter == letter_name:
				# Cria um novo botão para preencher a área
				var new_button = duplicate()
				
				# Encaixa a cópia da letra na área
				current_snap_area.is_occupied = true
				current_snap_area.modulate.a = 0.0  # Opacidade total ao encaixar
				new_button.position = current_snap_area.global_position - get_parent().global_position
				get_parent().add_child(new_button)
				is_snapped = true
				queue_free() # remove a letra do "teclado". Isso está aqui para imitar o jogo físico que serviu de inspiração, mas pode ser removido futuramente
				completed = lacunas.verify_gaps()
				if completed:
					get_tree().change_scene_to_file("res://scenes/parabenizacao.tscn")
			position = original_position # move o botão para a posição de origem
			accept_event()
	
	elif event is InputEventMouseMotion and is_dragging:
		position = get_global_mouse_position() - offset - get_parent().global_position
		check_snap_area()
		accept_event()

func check_snap_area(): 
	for word in lacunas.selected_words: # Cada palavra
		for letter in word: 
			if not letter[0].is_occupied:
				letter[0].modulate.a = 0.8  # Feedback visual para áreas disponíveis
	
	current_snap_area = null
	for word in lacunas.selected_words:
		for letter in word:
			if letter[0].is_occupied:
				continue
			if letter[0].get_global_rect().has_point(get_global_mouse_position()):
				current_snap_area = letter[0]
				current_snap_area_letter = letter[1]
				letter[0].modulate.a = 1.2  # Feedback visual para área sob o mouse
				break
