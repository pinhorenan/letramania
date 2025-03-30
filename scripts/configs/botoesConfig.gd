extends Control

@onready var botao_pontuacao = $"Pontuação"
@onready var botao_temporizador = $"Temporizador"
@onready var botao_click = get_node("Click")

func _ready() -> void:
	# Carrega convertendo para booleanos
	botao_pontuacao.button_pressed = Configuracoes.config.get("pontuacao_ativada", true) as bool
	botao_temporizador.button_pressed = Configuracoes.config.get("temporizador_ativado", true) as bool
	
	if botao_pontuacao is BaseButton:
		botao_pontuacao.toggled.connect(_on_pontuacao_toggled)
	if botao_temporizador is BaseButton:
		botao_temporizador.toggled.connect(_on_temporizador_toggled)

func _on_pontuacao_toggled(ativado: bool) -> void:
	botao_click.play()
	Configuracoes.config.pontuacao_ativada = ativado
	Configuracoes.salvar_todas_configuracoes()

func _on_temporizador_toggled(ativado: bool) -> void:
	botao_click.play()
	Configuracoes.config.temporizador_ativado = ativado
	Configuracoes.salvar_todas_configuracoes()

func _on_voltar_pressed() -> void:
	botao_click.play()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
