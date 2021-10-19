extends Area2D

signal coinCollected

func _on_CoinArea2D_body_entered(body):
	emit_signal("coinCollected")
	queue_free()
