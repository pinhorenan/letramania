extends Button

var is_dragging := false
var offset := Vector2()
var original_position := Vector2()
var current_snap_area: Node = null
var is_snapped := false  # Indica se a letra está encaixada

func _ready():
    original_position = position

func _gui_input(event: InputEvent) -> void:
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
            if current_snap_area and not current_snap_area.is_occupied:
                # Encaixa a letra na área
                current_snap_area.is_occupied = true
                current_snap_area.modulate.a = 1.0  # Opacidade total ao encaixar
                position = current_snap_area.global_position - get_parent().global_position
                is_snapped = true
                
                # Cria um novo botão na posição original
                var new_button = duplicate()
                new_button.position = original_position
                get_parent().add_child(new_button)
            else:
                # Retorna à posição original se não encaixar
                position = original_position
            accept_event()
    
    elif event is InputEventMouseMotion and is_dragging:
        position = get_global_mouse_position() - offset - get_parent().global_position
        check_snap_area()
        accept_event()

func check_snap_area():
    for area in get_tree().get_nodes_in_group("arrastaveis"):
        if not area.is_occupied:
            area.modulate.a = 0.5  # Feedback visual para áreas disponíveis
    
    current_snap_area = null
    for area in get_tree().get_nodes_in_group("arrastaveis"):
        if area.is_occupied:
            continue
        if area.get_global_rect().has_point(get_global_mouse_position()):
            current_snap_area = area
            area.modulate.a = 0.2  # Feedback visual para área sob o mouse
            break
