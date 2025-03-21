extends Control

@onready var background = $Background

func _ready():
	ajustar_background()

func _notification(what):
	if what == NOTIFICATION_RESIZED:
		ajustar_background()

func ajustar_background():
	if background and background.texture:
		background.size = get_viewport_rect().size
		background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
