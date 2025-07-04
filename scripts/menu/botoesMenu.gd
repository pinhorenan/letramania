extends Control

@export var bus_name: String = "Musica"  # Permite definir o nome do bus no editor
var musica: int
@onready var background = $Background
@onready var botao_click = get_node("Click")
var texture_normal
var texture_highlight
var texture_pressed
var next_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ajustar_background()
	musica = AudioServer.get_bus_index(bus_name)
	if Jogo.word_size == 6 and Jogo.vidas >= 0:
		$Iniciar.texture_normal = preload("res://assets/parabenizacao/Botões/InicioBase.png")
		$Iniciar.texture_hover = preload("res://assets/parabenizacao/Botões/InicioHighlight.png")
		$Iniciar.texture_pressed = preload("res://assets/parabenizacao/Botões/InicioPressed.png")
	if Jogo.vidas < 0:
		Jogo.word_size = 3
		Jogo.vidas = Configuracoes.config["vidas"]
func ajustar_background():
	if background and background.texture:
		background.size = get_viewport_rect().size
		background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
		
func _on_sair_pressed() -> void:
	botao_click.play()
	get_tree().quit()

func _on_musga_on_off_pressed() -> void:
	botao_click.play()
	var is_muted = AudioServer.is_bus_mute(musica)
	AudioServer.set_bus_mute(musica, not is_muted)

func _on_iniciar_pressed() -> void:
	botao_click.play()
	if Jogo.word_size < 7:
		Jogo.word_size += 1
		next_scene = "res://scenes/game.tscn"
	else:
		if Jogo.word_size == 7:
			next_scene = "res://scenes/game.tscn"
		else:
			next_scene = "res://scenes/menu.tscn"
		Jogo.word_size = 4 # Voltando para a primeira fase
		Jogo.tempo_decorrido = 0.0 # Resetando temporizador
		Jogo.vidas = Configuracoes.config["vidas"]
	get_tree().change_scene_to_file(next_scene)


func _on_configuraçoes_pressed() -> void:
	botao_click.play()
	get_tree().change_scene_to_file("res://scenes/config.tscn")
