extends Area2D

var t := -5.0
var speed := 2.5
var expr := Expression.new()
var valid := false

func start_movement(formula: String):
	$"camara_disparo".make_current()
	self.visible = true

	# Convertir ^ por pow()
	formula = _convert_powers(formula)

	expr = Expression.new()
	var error = expr.parse(formula, ["x"])
	if error != OK:
		print("Error en expresión:", expr.get_error_text())
		valid = false
		return

	valid = true
	t = 0.0


func _process(delta):
	if not valid:
		return

	t += delta * speed

	# Ejecutar solo con el array
	var y = expr.execute([t])

	if expr.has_execute_failed():
		print("Error ejecutando expresión:", expr.get_error_text())
		valid = false
		return

	global_position = Vector2(t * 50, -y * 50)



func _convert_powers(formula:String) -> String:
	var regex = RegEx.new()
	regex.compile(r"(\([^()]+\)|[a-zA-Z0-9\.]+)\^([0-9]+)")

	while true:
		var result = regex.search(formula)
		if result == null:
			break

		var base = result.get_string(1)
		var exp = result.get_string(2)
		var pow_str = "pow(%s,%s)" % [base, exp]

		formula = formula.substr(0, result.get_start()) + pow_str + formula.substr(result.get_end())

	return formula



# -----------------------------
# Cuando sale de la pantalla
# -----------------------------
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Guarda la cámara ANTES de borrar la bala
	var camara1 = get_node("/root/main/camapra principal")

	# Instancia otra bala en la posición (0,0)
	var new_bullet = preload("res://tsenes/disparo.tscn").instantiate()
	new_bullet.global_position = Vector2(0, 0)
	get_tree().current_scene.add_child(new_bullet)

	# Ahora sí puedes borrar esta bala
	queue_free()

	# Y mover la cámara
	camara1.make_current()
