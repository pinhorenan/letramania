extends Control

@export var bus_name: String = "Musica"
var musica: int
@onready var label_tempo = $Tempo
@onready var label_pontuacao = $Pontuação
@onready var label_vidas = $Vidas
var tempo_decorrido: float = 0.0
var temporizador_ligado: bool = false
var vidas: int = 3
var pontuacao: int = 0

func _ready() -> void:
	label_pontuacao.visible = Configuracoes.config.pontuacao_ativada
	label_tempo.visible = Configuracoes.config.temporizador_ativado
	vidas = Configuracoes.config.vidas  # Valor inicial
	pontuacao = 0  # Começa do zero
	atualizar_ui_vidas()
	atualizar_ui_pontos()
	
	check_snap_area()
	
	musica = AudioServer.get_bus_index(bus_name)
	iniciar_temporizador()  # Inicia o contador
	
	# AJUSTES PRAS LABELS
	var label_configs = LabelSettings.new()
	var fonte = load("res://recursos/musicas e fontes/Gilroy-Bold.ttf")
	label_configs.font = fonte
	label_configs.font_size = 24
	label_configs.font_color = Color.BLACK
	label_tempo.label_settings = label_configs
	label_pontuacao.label_settings = label_configs
	label_vidas.label_settings = label_configs
	label_vidas.label_settings.font_size = 36

func _process(delta):
	if temporizador_ligado:
		tempo_decorrido += delta
		atualizar_ui_tempo()

# ----------------------------- Labels

func iniciar_temporizador():
	temporizador_ligado = true

func parar_temporizador():
	temporizador_ligado = false

func resetar_temporizador():
	tempo_decorrido = 0.0

func atualizar_ui_tempo():
	var minutos = int(tempo_decorrido / 60)
	var segundos = int(tempo_decorrido) % 60
	label_tempo.text = "%02d:%02d" % [minutos, segundos]
	
func atualizar_ui_vidas():
	label_vidas.text = "Vidas: %02d" % vidas
	
func atualizar_ui_pontos():
	label_pontuacao.text = "%02d" % pontuacao
	
func _on_pause_changed(paused: bool):
	temporizador_ligado = !paused
	
# ----------------------------- Música

func _on_musga_on_off_pressed() -> void:
	var is_muted = AudioServer.is_bus_mute(musica)
	AudioServer.set_bus_mute(musica, not is_muted)

# ----------------------------- Arrastável

func check_snap_area():
	for area in get_tree().get_nodes_in_group("arrastaveis"):
			if not area.is_occupied:
				area.modulate.a = 0.8  # Feedback visual para áreas disponíveis
