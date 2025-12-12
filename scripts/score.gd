extends Control
func _process(delta: float) -> void:
	var text_score=str(global.score)
	$Label.text="score = "+text_score
