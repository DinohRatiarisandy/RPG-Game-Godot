class_name EnemyMovement;

extends CharacterBody2D

@onready var dead_anim := preload("res://Scenes/effects/dead_fx.tscn");
@onready var gui = $"../../GUI";
@export var speed := 10;

var current_state_machine = enemy_state.MOVE_DOWN;
var dir;
var health := 3;

enum enemy_state {MOVE_RIGHT, MOVE_LEFT, MOVE_UP, MOVE_DOWN, DEAD};

const COIN = preload("res://Scenes/coin.tscn");

func _physics_process(_delta):
	if health <= 0:
		current_state_machine = enemy_state.DEAD;

	match current_state_machine:
		enemy_state.MOVE_RIGHT:
			move_right()

		enemy_state.MOVE_LEFT:
			move_left()

		enemy_state.MOVE_UP:
			move_up();

		enemy_state.MOVE_DOWN:
			move_down();
		
		enemy_state.DEAD:
			dead();
		
	move_and_slide();


func random_generation():
	randomize();
	dir = randi() % 4;
	random_direction();


func random_direction():
	match dir:
		0:
			current_state_machine = enemy_state.MOVE_RIGHT;
		1:
			current_state_machine = enemy_state.MOVE_LEFT;
		2:
			current_state_machine = enemy_state.MOVE_UP;
		3:
			current_state_machine = enemy_state.MOVE_DOWN;


func move_right():
	velocity = Vector2.RIGHT * speed;
	$AnimationEnemy.play("Move_right");


func move_left():
	velocity = Vector2.LEFT * speed;
	$AnimationEnemy.play("Move_left");


func move_down():
	velocity = Vector2.DOWN * speed;
	$AnimationEnemy.play("Move_down");


func move_up():
	velocity = Vector2.UP * speed;
	$AnimationEnemy.play("Move_up");


func dead():
	dead_animation();
	queue_free();


func dead_animation():
	var play_dead_anim = dead_anim.instantiate();
	play_dead_anim.global_position = global_position;
	get_tree().get_root().add_child(play_dead_anim);
	coin_loot();


func coin_loot():
	var regenerate_coin = COIN.instantiate();
	regenerate_coin.global_position = global_position;
	gui.link_hit_method(regenerate_coin);
	get_tree().get_root().add_child(regenerate_coin);
