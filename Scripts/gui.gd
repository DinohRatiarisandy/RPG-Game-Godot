extends Node2D

@onready var hearts = $CanvasLayer/Hearts;
@onready var coins_count_label = $CanvasLayer/CoinsCount;
@onready var coins = $"../Coins";

func _ready():
	for coin in coins.get_children():
		coin.hit.connect(_on_gui_update);
	
	for i in range(PlayerData.health):
		var new_heart = Sprite2D.new();
		new_heart.texture = hearts.texture;
		new_heart.hframes = hearts.hframes;
		new_heart.position.x = i * 18;
		new_heart.frame = 4;
		hearts.add_child(new_heart);


func _on_gui_update():
	coins_count_label.text = str(PlayerData.coins_count);
	
	if hearts.get_children().size() == 1:
		hearts.queue_free();
		return;
	
	hearts.get_children()[-1].queue_free();
