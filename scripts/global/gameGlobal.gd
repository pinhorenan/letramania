extends Node2D

const FILE_PATH = "user://dados_partidas.csv"
#var is_dragging = false
var word_size = 3
var tempo_decorrido: float = 0.0

var acertos = 0
var erros = 0
var erro_posicao = 0
var erro_escolha = 0
var letras_selecionadas = 0

var time_start: String #OK
var time_end: String # OK
var media_letra: float #OK
var media_letra_certa: float #OK
var aux_time := 0.0  
var total_idle_time := 0.0 #OK
var total_idle_time1 := 0.0 #OK
var total_idle_time2 := 0.0 #OK
var total_idle_time3 := 0.0 #OK

func add_letras_selecionadas():
	letras_selecionadas += 1
	
func add_acertos():
	acertos += 1

func add_erros():
	erros += 1

func add_erro_posicao():
	erro_posicao += 1

func add_erro_escolha():
	erro_escolha += 1

func add_idle_time(time: float) -> void:
	total_idle_time += time
	#print("Tempo total de inatividade:", total_idle_time / 1000.0, "segundos")
	
func calcular_media():
	media_letra = tempo_decorrido / letras_selecionadas
	media_letra_certa = tempo_decorrido / acertos

func set_inatividade_fase1():
	total_idle_time1 = total_idle_time #  /1000

func set_inatividade_fase2():
	total_idle_time2 = (total_idle_time - total_idle_time1) #  /1000
	
	
func set_inatividade_fase3():
	total_idle_time3 = (total_idle_time - total_idle_time1 - total_idle_time2) #  /1000
	
func get_time():
	var current_date_time = Time.get_datetime_dict_from_system()
	var formatted_date_time = "%02d-%02d-%04d %02d:%02d:%02d" % [
	current_date_time["day"], 
	current_date_time["month"], 
	current_date_time["year"], 
	current_date_time["hour"], 
	current_date_time["minute"], 
	current_date_time["second"]
	]
	return formatted_date_time

# Função para salvar os dados no CSV
func salvar_dados_no_csv():
	var linhas = []
	var id: int

	# Verifica se o arquivo já existe
	if FileAccess.file_exists(FILE_PATH):
		var file = FileAccess.open(FILE_PATH, FileAccess.READ)
		if file: 
			while not file.eof_reached():
				var line = file.get_line()
				if line != "":
					linhas.append(line)
			file.close()
		else:
			push_error("Erro ao abrir arquivo")

	# Adiciona o cabeçalho se o arquivo estava vazio
	if linhas.is_empty():
		linhas.append("ID, Início, Fim, Tempo de Partida, Total Letras Selecionadas, Acertos, Erros, Erros Escolha, Erros Posição, Tempo Ociosidade Total, Tempo Ociosidade Fase 1, Tempo Ociosidade Fase 2, Tempo Ociosidade Fase 3, Tempo Médio por Letra, Tempo Médio por Acerto")

	# Adiciona os novos dados
	linhas.append(str(id) + "," + str(time_start) + "," + str(time_end) + "," + str(tempo_decorrido) + "," + str(letras_selecionadas) + "," + str(acertos) + "," + str(erros) + "," + str(erro_escolha) + "," + str(erro_posicao) + "," + str(total_idle_time) + "," + str(total_idle_time1) + "," + str(total_idle_time2) + "," + str(total_idle_time3) + "," + str(media_letra) + "," + str(media_letra_certa))
	# Salva tudo novamente no arquivo
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file:
		for line in linhas:
			file.store_line(line)
		print("Dados salvos no arquivo CSV.")
	else:
		print("Erro")
