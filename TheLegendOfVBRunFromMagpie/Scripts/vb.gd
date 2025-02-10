extends Area2D

const HEALTH = 50

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.health += HEALTH
		print("HEYA! Health increased by ", HEALTH)
		queue_free()
