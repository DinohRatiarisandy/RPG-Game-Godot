class_name Player;

extends CharacterBody2D

@export var speed := 70;

@onready var sword_attack_collision = $SwordAttackArea/SwordAttackCollision;
@onready var animation_tree = $AnimationTree
@onready var anim_state_machine = animation_tree.get("parameters/playback");

var direction := Vector2.ZERO;

func _ready():
	sword_attack_collision.disabled = true;


func _physics_process(_delta):
	move();


func move() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");

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

	move_and_slide()
