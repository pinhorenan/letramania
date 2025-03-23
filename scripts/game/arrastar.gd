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
var last_release_time := 0  
var idle_time := 0  

func _ready():
	Jogo.aux_time = Time.get_ticks_msec()
	pass

func _gui_input(event: InputEvent) -> void:
	#<<<<<<< HEAD
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:  # Botão pressionado
			idle_time = Time.get_ticks_msec() - Jogo.aux_time  
			Jogo.add_idle_time(idle_time)  
			if is_snapped:
				# Se a letra já está encaixada, permita movê-la novamente
				current_snap_area.is_occupied = false
				current_snap_area.modulate.a = 1.0  # Resetar opacidade
				current_snap_area = null
				is_snapped = false
			is_dragging = true
			offset = get_local_mouse_position()
		else:  # Botão solto
			Jogo.aux_time = Time.get_ticks_msec() 
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
				Jogo.add_acertos()
				queue_free() # remove a letra do "teclado". Isso está aqui para imitar o jogo físico que serviu de inspiração, mas pode ser removido futuramente
				completed = lacunas.verify_gaps()
				if completed:
					get_parent().get_parent().parar_temporizador() # Sim. Se possível eu arrumo depois
					if Jogo.word_size < 6:
						idle_time = Time.get_ticks_msec() - Jogo.aux_time  
						Jogo.add_idle_time(idle_time)
						if Jogo.word_size == 4:
							Jogo.set_inatividade_fase1()
							print(Jogo.total_idle_time1)
						elif Jogo.word_size == 5:
							Jogo.set_inatividade_fase2()
							print(Jogo.total_idle_time2)
						get_tree().change_scene_to_file("res://scenes/prox_fase.tscn")
					else:
						if Jogo.word_size == 6:
							Jogo.set_inatividade_fase3()
						get_tree().change_scene_to_file("res://scenes/fim.tscn")
			else:
				Jogo.add_erros()
				var palavra_errada = null
				# Encontrar a palavra correspondente à lacuna onde a letra foi solta
				for palavra_atual in lacunas.selected_words:
					for letra_posicao in palavra_atual:
						if letra_posicao[0] == current_snap_area:
							palavra_errada = palavra_atual
							break
					if palavra_errada:
						break  # Palavra encontrada, pode sair do loop
				if palavra_errada:
					verify_type_error(letter_name, palavra_errada)
					
			Jogo.add_letras_selecionadas()
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

#função para verificar que tipo de erro
func verify_type_error(letter_name: String, word: Array):
	var correct_letters = []  # Lista de letras da palavra correta
	for pair in word:  # Percorre cada posição da palavra
		correct_letters.append(pair[1])

	if letter_name in correct_letters:
		Jogo.add_erro_posicao()
		return  # A letra existe, mas foi colocada no lugar errado
	else:
		Jogo.add_erro_escolha()
		
		return  # A letra não existe na palavra
