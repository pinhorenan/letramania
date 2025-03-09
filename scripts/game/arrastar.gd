extends Button

var is_dragging := false
var offset := Vector2()
var original_position := Vector2()
var current_snap_area: Node = null

func _ready():
	original_position = position

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = event.pressed
		if is_dragging:
			offset = get_local_mouse_position()
			if current_snap_area:
				current_snap_area.is_occupied = false
				current_snap_area.modulate.a = 1.0  # Resetar opacidade
				current_snap_area = null
		else:
			if current_snap_area and not current_snap_area.is_occupied:
				current_snap_area.is_occupied = true
				current_snap_area.modulate.a = 1.0  # Opacidade total ao encaixar
				position = current_snap_area.global_position - get_parent().global_position
			else:
				position = original_position
			accept_event()
	
	elif event is InputEventMouseMotion and is_dragging:
		position = get_global_mouse_position() - offset - get_parent().global_position
		check_snap_area()
		accept_event()

func check_snap_area():
	for area in get_tree().get_nodes_in_group("arrastaveis"):
		if not area.is_occupied:
			area.modulate.a = 0.5
	
	current_snap_area = null
	for area in get_tree().get_nodes_in_group("arrastaveis"):
		if area.is_occupied:
			continue
		if area.get_global_rect().has_point(get_global_mouse_position()):
			current_snap_area = area
			area.modulate.a = 0.2
			break
