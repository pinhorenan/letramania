extends Control

@onready var botao_pontuacao = $"Pontuação"  # Substitua pelo caminho real do seu botão
@onready var botao_temporizador = $"Temporizador"

func _ready() -> void:
	# Carrega o estado salvo ao iniciar
	botao_pontuacao.button_pressed = Configuracoes.config.get("pontuacao_ativada", true)
	botao_temporizador.button_pressed = Configuracoes.config.get("temporizador_ativado", true)
	
	# Conecta o sinal de toggle se for CheckBox/Button toggle
	if botao_pontuacao is BaseButton:
		botao_pontuacao.toggled.connect(_on_pontuacao_toggled)
	if botao_temporizador is BaseButton:
		botao_temporizador.toggled.connect(_on_temporizador_toggled)

func _on_pontuacao_toggled(ativado: bool) -> void:
	Configuracoes.config.pontuacao_ativada = ativado
	Configuracoes.salvar_configuracoes()
	
func _on_temporizador_toggled(ativado: bool) -> void:
	Configuracoes.config.temporizador_ativado = ativado
	Configuracoes.salvar_configuracoes()

func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
