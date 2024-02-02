extends EnemyMovement;

@onready var hearts = $"../../GUI/CanvasLayer/Hearts";
@onready var player = $"../../Player";

func _ready():
	random_generation()


func _on_timer_timeout():
	random_generation()
	$Timer.start();


func _on_hit_box_area_entered(area):
	if area.is_in_group("sword"):
		health -= 1;
		flash_hurt();

func _on_hit_box_body_entered(body):
	if body.name == "Player":
		update_gui_player_life();


func update_gui_player_life():
	PlayerData.health -= 1;
	player.flash_hurt();
	if hearts.get_children().size() == 1:
		hearts.queue_free();
		return;
	
	hearts.get_children()[-1].queue_free();


func flash_hurt():
	$SpriteEnemy.material.set_shader_parameter("flash_modifier", 1);
	await get_tree().create_timer(0.3).timeout;
	$SpriteEnemy.material.set_shader_parameter("flash_modifier", 0);
