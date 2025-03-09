extends Control

@export var bus_name: String = "Musica"  # Permite definir o nome do bus no editor
var musica: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musica = AudioServer.get_bus_index(bus_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_musga_on_off_pressed() -> void:
	var is_muted = AudioServer.is_bus_mute(musica)
	AudioServer.set_bus_mute(musica, not is_muted)
