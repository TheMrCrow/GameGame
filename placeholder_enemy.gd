extends CharacterBody2D


const SPEED = 45.0
const JUMP_VELOCITY = -200.0
@export var look_direction = -1
@onready var sprite: Sprite2D = $Sprite2D
var turning : bool = false
#var target_position : Vector2

func _physics_process(delta: float) -> void:
	#target_position = Player.position
	# Add the gravity.
	if turning == false:
		if not is_on_floor():
			velocity += get_gravity() * delta
				# Handle jump
		elif Player.position.y < position.y and Player.is_on_floor() and abs(velocity.x) == 0:
			velocity.y = JUMP_VELOCITY

		if abs(Player.position.x) - abs(position.x) < 200:
			
			if Player.position.x > position.x:
				if look_direction < 0:
					turn(1)
				velocity.x = 1 * SPEED
			else:
				if look_direction > 0:
					turn(-1)
				velocity.x = -1 * SPEED

func turn(direction):
	turning = true
	await get_tree().create_timer(0.3).timeout
	turning = false
	if direction < 0:
		sprite.scale.x = -0.086
	else:
		sprite.scale.x = 0.086


	move_and_slide()
