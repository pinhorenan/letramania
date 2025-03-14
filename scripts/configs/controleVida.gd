extends Control

# Referências para os botões e o label
@onready var label = $Vidas
@onready var btn_aumentar = $AumentarVidas
@onready var btn_diminuir = $DiminuirVidas

var vidas_iniciais: int:
	set(value):
		# Garante que o valor sempre fique entre 1 e 99
		value = clampi(value, 1, 99)
		Configuracoes.config.vidas = value
		Configuracoes.salvar_todas_configuracoes()
		label.text = str(value)
	get:
		return Configuracoes.config.vidas
		
func _ready():
	
	vidas_iniciais = Configuracoes.config.vidas
	label.text = str(vidas_iniciais)

	# Configurações do Label (Godot 4)
	var label_settings = LabelSettings.new()
	var fonte = load("res://recursos/musicas e fontes/Gilroy-Bold.ttf")
	label_settings.font = fonte
	label_settings.font_size = 40
	label_settings.font_color = Color.BLACK
	label.label_settings = label_settings
	
	# Conectar os sinais dos botões
	btn_aumentar.connect("pressed", _aumentar_vidas)
	btn_diminuir.connect("pressed", _diminuir_vidas)

# Função para atualizar o label com a quantidade de vidas
func atualizar_vidas():
	Configuracoes.salvar_todas_configuracoes()
	label.text = str(vidas_iniciais)  # Atualiza o texto do Label

# Função chamada quando o botão de aumentar é pressionado
func _aumentar_vidas():
	if Configuracoes.config.vidas == 99:
		vidas_iniciais = 1
	else:
		vidas_iniciais += 1

func _diminuir_vidas():
	if Configuracoes.config.vidas == 1:
		vidas_iniciais = 99
	else:
		vidas_iniciais -= 1
