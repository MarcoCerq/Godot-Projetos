extends Area2D

func _on_CoinStaticBody2D_body_entered(body):
	queue_free()
