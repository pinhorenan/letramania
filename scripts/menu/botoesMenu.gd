extends Control

@export var bus_name: String = "Musica"  # Permite definir o nome do bus no editor
var musica: int
@onready var background = $Background
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ajustar_background()
	musica = AudioServer.get_bus_index(bus_name)
	
func ajustar_background():
	if background and background.texture:
		background.size = get_viewport_rect().size
		background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
		
func _on_sair_pressed() -> void:
	get_tree().quit()

func _on_musga_on_off_pressed() -> void:
	var is_muted = AudioServer.is_bus_mute(musica)
	AudioServer.set_bus_mute(musica, not is_muted)

func _on_iniciar_pressed() -> void:
	Jogo.word_size += 1
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_configuraçoes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/config.tscn")
