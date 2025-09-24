class_name player
extends CharacterBody2D


@export var speed = 80
@export var jump_time = 100
@export var jump_speed = 1

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimSprite
@onready var health: Node2D = $Health

@export var attacking : bool = false
var jumping : bool = true
var direction

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Idle animation
	#if is_on_floor() and velocity.x == 0:
		#animation.play("Idle")
	if attacking == false:
		animation.play("Idle")


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_time = 14
		jumping = true
	if Input.is_action_pressed("ui_accept") and jumping == true and jump_time > 0:
		velocity.y = jump_speed * -180
		jump_time -= 1
	else:
		jumping = false

	# Movement
	direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("Attack"):
		if direction >= 0:
			attacking = true
			animation.play("Attack")
		else:
			attacking = true
			animation.play("AttackLeft")
