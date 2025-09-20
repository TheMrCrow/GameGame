extends CharacterBody2D


@export var speed = 45.0
@export var jump_height = 1
@export var turn_slow = 1.0 # slows down turn speed the higher it is

@export var look_direction = -1 # used to determine if the enemy should turn towards the player
@export var can_jump : bool = true

@onready var sprite: Sprite2D = $Sprite2D
var turning : bool = false # used to disable movement when turning

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if turning == false:
		if not is_on_floor():
			velocity += get_gravity() * delta
	# Handle jump
		elif can_jump == true and Player.position.y < position.y and Player.is_on_floor() and abs(velocity.x) == 0:
			velocity.y = jump_height * -180

	# turning and movement
		if abs(Player.position.x) - abs(position.x) < 200:
			if Player.position.x > position.x:
				if look_direction > 0:
					turn(-1) # begin turning
				velocity.x = 1 * speed
			else:
				if look_direction < 0:
					turn(1) # begin turning
				velocity.x = -1 * speed
		
		move_and_slide()

func turn(direction):
	turning = true
	look_direction = direction

	await get_tree().create_timer(turn_slow).timeout
	turning = false

	sprite.scale.x = 0.086 * direction
