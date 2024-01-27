class_name Player;

extends CharacterBody2D

enum player_state {MOVE, SWORD_ATTACK, JUMP, DEAD};

@export var speed := 70;

@onready var sword_attack_collision = $SwordAttackArea/SwordAttackCollision;
@onready var animation_tree = $AnimationTree;
@onready var anim_state_machine = animation_tree.get("parameters/playback");
@onready var player_collision = $PlayerCollision;

var direction := Vector2.ZERO;
var current_state := player_state.MOVE;

func _ready():
	sword_attack_collision.disabled = true;


func _physics_process(_delta):
	match current_state:
		player_state.MOVE:
			move();
		player_state.SWORD_ATTACK:
			sword_attack();
		player_state.JUMP:
			jump();
		player_state.DEAD:
			dead();


func move() -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down");

	if direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", direction);
		animation_tree.set("parameters/Walk/blend_position", direction);
		animation_tree.set("parameters/SwordAttack/blend_position", direction);
		animation_tree.set("parameters/Jump/blend_position", direction);
		anim_state_machine.travel("Walk");
		velocity = direction * speed;

	if direction == Vector2.ZERO:
		anim_state_machine.travel("Idle");
		velocity = Vector2.ZERO;

	if Input.is_action_just_pressed("sword_attack"):
		current_state = player_state.SWORD_ATTACK;
	
	if Input.is_action_just_pressed("jump"):
		current_state = player_state.JUMP;

	move_and_slide()


func sword_attack():
	anim_state_machine.travel("SwordAttack");


func jump():
	anim_state_machine.travel("Jump");
	velocity = direction * speed;
	
	move_and_slide();


func dead():
	pass


func _on_state_reset():
	current_state = player_state.MOVE;
	player_collision.disabled = false;


func _clear_player_collision():
	player_collision.disabled = true;


func _create_player_collision():
	player_collision.disabled = false;
