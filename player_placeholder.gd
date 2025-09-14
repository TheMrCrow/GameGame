extends Camera2D

func _physics_process(delta):
	print(position)
	if Input.is_action_pressed("Right"):
		position.x += 10
	if Input.is_action_pressed("Left"):
		position.x -= 10
	if Input.is_action_pressed("Down"):
		position.y += 10
	if Input.is_action_pressed("Up"):
		position.y -= 10 
