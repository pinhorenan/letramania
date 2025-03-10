extends Node

const config_path = "user://configuracao.cfg"

func _ready():
	load_settings()  # Carrega ao iniciar
	
# --------------------------- Configurações da música ---------------------------
var is_music_on: bool = true : set = set_music_on
signal music_state_changed(is_on)

func set_music_on(value: bool) -> void:
	is_music_on = value
	emit_signal("music_state_changed", is_music_on)
	save_settings()  # Salva automaticamente ao alterar
	# Controle do áudio
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Musica"), not is_music_on)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "is_music_on", is_music_on)
	config.save(config_path)

func load_settings():
	var config = ConfigFile.new()
	if config.load(config_path) == OK:
		is_music_on = config.get_value("audio", "is_music_on", true)
	else:
		is_music_on = true  # Valor padrão

# ----------------------------------------------- Configurações do jogo
# Valores jogo padrão
var config = {
	"vidas": 3,
	"pontuacao_ativada": true,
	"temporizador_ativado": true
}

# Salva as configurações em disco
func salvar_configuracoes():
	var config_file = ConfigFile.new()
	config_file.set_value("config", "vidas", config.vidas)
	config_file.set_value("config", "pontuacao_ativada", config.pontuacao_ativada)
	config_file.set_value("config", "temporizador_ativado", config.temporizador_ativado)
	config_file.save(config_path)

# Carrega as configurações do disco
func carregar_configuracoes():
	var config_file = ConfigFile.new()
	var erro = config_file.load(config_path)
	
	if erro == OK:
		config.vidas = config_file.get_value("config", "vidas", 3)
		config.pontuacao_ativada = config_file.get_value("config", "pontuacao_ativada", true)
		config.temporizador_ativado = config_file.get_value("config", "temporizador_ativado", false)
	else:
		salvar_configuracoes()  # Cria arquivo com valores padrão
