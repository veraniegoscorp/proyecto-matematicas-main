extends Node2D

var funcion_usuario : String = ""

func _ready():
	$Control/LineEdit.text_submitted.connect(_on_text_entered)

func _on_text_entered(text):
	funcion_usuario = text
	print("Función ingresada:", funcion_usuario)
	# Reiniciamos el movimiento de la bala
	$penguin.global_position = Vector2(0, 0)
	$disparo.start_movement(funcion_usuario)


func _on_bad_pigies_area_entered(area: Area2D) -> void:
	if area.name=="disparo":
		$"music_and_sounds/bad_piggies".play()


func _on_bad_pigies_area_exited(area: Area2D) -> void:
	if area.name=="disparo":
		$"music_and_sounds/bad_piggies".stop()


func _on_terraria_gl_area_entered(area: Area2D) -> void:
	if area.name=="disparo":
		$"music_and_sounds/terraria_galaxy".play()


func _on_terraria_gl_area_exited(area: Area2D) -> void:
	if area.name=="disparo":
		$"music_and_sounds/terraria_galaxy".stop()
