extends Node

# Valores padrão
var config = {
	"vidas": 3,
	"pontuacao_ativada": true,
	"temporizador_ativado": true
}

# Caminho do arquivo de configuração
var config_path = "user://configuracao.cfg"

func _ready():
	carregar_configuracoes()

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
