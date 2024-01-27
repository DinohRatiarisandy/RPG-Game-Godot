class_name Crate;

extends StaticBody2D;

@onready var crate_animation = $CrateAnimation

func _on_crate_hit_area_area_entered(area):
	if area.name == "SwordAttackArea":
		crate_animation.play("Destroyed");
		await crate_animation.animation_finished;
		queue_free();
