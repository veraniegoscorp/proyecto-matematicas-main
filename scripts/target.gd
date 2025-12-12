extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")



func _on_area_entered(area: Area2D) -> void:
	if area.name=="disparo":
		global.score +=100
		$"/root/main/music_and_sounds/penguin_die".play()
		queue_free()
