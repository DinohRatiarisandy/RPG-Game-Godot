extends Area2D

signal hit;

func _on_body_entered(body):
	if body.name == "Player":
		PlayerData.coins_count += 1;

		hit.emit();
		
		queue_free();
