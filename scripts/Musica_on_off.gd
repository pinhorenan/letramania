extends TextureButton

@export var bus_name: String = "Musica"  # Permite definir o nome do bus no editor
var musica: int

func _ready() -> void:
	musica = AudioServer.get_bus_index(bus_name)

func _on_pressed() -> void:
	var is_muted = AudioServer.is_bus_mute(musica)
	AudioServer.set_bus_mute(musica, not is_muted)
