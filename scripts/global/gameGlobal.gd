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

var pontos1: int = 0 #OK
var pontos2: int = 0#OK
var pontos3: int = 0#OK

var tempo1: float = 0.0
var tempo2: float = 0.0
var tempo3: float = 0.0

var acertos1: int = 0
var acertos2: int = 0
var acertos3: int = 0

var erros1: int = 0
var erros2: int = 0
var erros3: int = 0

var erro_posicao1: int = 0
var erro_posicao2: int = 0
var erro_posicao3: int = 0

var erro_escolha1: int = 0
var erro_escolha2: int = 0
var erro_escolha3: int = 0

var completo: String

var vidas: int
var pontuacao: int

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
	pontos1 = pontuacao
	tempo1 = tempo_decorrido
	acertos1 =  acertos
	erros1 = erros
	erro_escolha1 = erro_escolha
	erro_posicao1 = erro_posicao


func set_inatividade_fase2():
	total_idle_time2 = (total_idle_time - total_idle_time1) #  /1000
	pontos2 = pontuacao - pontos1
	tempo2 = tempo_decorrido - tempo1
	acertos2 =  acertos - acertos1
	erros2 = erros - erros1
	erro_escolha2 = erro_escolha - erro_escolha1
	erro_posicao2 = erro_posicao - erro_posicao1
	
func set_inatividade_fase3():
	total_idle_time3 = (total_idle_time - total_idle_time1 - total_idle_time2) #  /1000
	pontos3 = pontuacao - pontos1 - pontos2
	tempo3 = tempo_decorrido - tempo1 - tempo2
	acertos3 =  acertos - acertos1 - acertos2
	erros3 = erros - erros1 - erros2
	erro_escolha3 = erro_escolha - erro_escolha1 - erro_escolha2
	erro_posicao3 = erro_posicao - erro_posicao1 - erro_posicao2
	
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
	time_end = get_time()
	var linhas = []
	var id: int = 1  # ID inicial caso o arquivo não exista
	var erros_area_invalida: int = erros - erro_escolha - erro_posicao

	# Converter tempos para segundos
	total_idle_time /= 1000
	total_idle_time1 /= 1000
	total_idle_time2 /= 1000
	total_idle_time3 /= 1000
	
	calcular_media()

	# Caminho acessível no Android (Downloads)
	var pasta_destino = "/storage/emulated/0/Download"
	var caminho_arquivo = pasta_destino + "/dados_partidas.csv"

	# Verifica se o arquivo existe
	if FileAccess.file_exists(caminho_arquivo):
		var file = FileAccess.open(caminho_arquivo, FileAccess.READ)
		if file:
			while not file.eof_reached():
				var line = file.get_line()
				if line != "":
					linhas.append(line)

			# Incrementar o ID a partir da última linha
			if linhas.size() > 1:
				var last_line = linhas[-1].split(",")  
				id = int(last_line[0]) + 1  

			file.close()
		else:
			push_error("Erro ao abrir o arquivo")

	# Adiciona o cabeçalho se o arquivo estava vazio
	if linhas.is_empty():
		linhas.append("ID, Completo?, Início, Fim, Tempo de Partida (s), Total Letras Selecionadas, Acertos, Erros, Erros Escolha, Erros Posição, Erro Área Inválida, Tempo Ociosidade Total (s), Pontuação Total, Tempo f1 (s), Tempo Ociosidade f1 (s), Acertos f1, Erros f1, Erros Escolha f1, Erros Posição f1, Pontos f1, Tempo f2 (s), Tempo Ociosidade f2 (s), Acertos f2, Erros f2, Erros Escolha f2, Erros Posição f2, Pontos f2, Tempo f3 (s), Tempo Ociosidade f3 (s), Scertos f3, Erros f3, Erros Escolha f3, Erros posição f3, Pontos f3, Tempo Médio por Letra (s), Tempo Médio por Acerto (s)")
	# Adiciona os novos dados
	linhas.append(str(id) + "," + str(completo) + "," + str(time_start) + "," + str(time_end) + "," + "%.2f" % tempo_decorrido + "," + str(letras_selecionadas) + "," + str(acertos) + "," + str(erros) + "," + str(erro_escolha) + "," + str(erro_posicao) + "," + str(erros_area_invalida) + "," + "%.2f" % total_idle_time + "," + str(pontuacao) + ","  + "%.2f" % tempo1 + "," + "%.2f" % total_idle_time1 + ","  + str(acertos1) + ","  + str(erros1) + ","  + str(erro_escolha1) + "," + str(erro_posicao1) + "," + str(pontos1) + "," + "%.2f" % tempo2 + "," + "%.2f" % total_idle_time2 + ","  + str(acertos2) + ","  + str(erros2) + ","  + str(erro_escolha2) + "," + str(erro_posicao2) + "," + str(pontos2) + "," + "%.2f" % tempo3 + "," + "%.2f" % total_idle_time3 + ","  + str(acertos3) + ","  + str(erros3) + ","  + str(erro_escolha3) + "," + str(erro_posicao3) + "," + str(pontos3) + "," + "%.2f" % media_letra + "," + "%.2f" % media_letra_certa)
	# Salva tudo novamente no arquivo
	var file = FileAccess.open(caminho_arquivo, FileAccess.WRITE)
	if file:
		for line in linhas:
			file.store_line(line)
		file.close()
		print("✅ Dados salvos em: " + caminho_arquivo)
	else:
		push_error("❌ Erro ao salvar o arquivo!")
