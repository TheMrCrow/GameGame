extends Node2D

var scenes : Dictionary = {"test_scene": "res://Levels/example_scene.tscn",
							"targettest_scene": "res://Levels/target_scene.tscn",
							"MurderMansion": "res://Levels/MurderMansionInterior.tscn",
							"DEFUALT3": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT4": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT5": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT6": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT7": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT8": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT9": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT10": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT11": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT12": "res://Levels/DEFAULT.tcsn", 
							"DEFUALT13": "res://Levels/DEFAULT.tcsn",}
var transition_type : Array = ["Fade_Black", "Fade_White", "Swipe", "Clock", "Circle", "Diamond"]
var spawn_door = null

# sends the player to the target scene after entering a door
func go_to_level(target_scene, target_door): 
	var scene_to_load = scenes.get(target_scene, null)
	if scene_to_load != null:
		var packed_scene = load(scene_to_load)
		play_transition(0.15)
		await get_tree().create_timer(0.15).timeout
		Player.get_node("PlayerCamera").set_position_smoothing_enabled(false)
		get_tree().change_scene_to_packed(packed_scene)
		await get_tree().create_timer(0.05).timeout
		# place player at door position
		#if get_tree().current_scene.is_in_group("rooms"):
		#	GameManager.get_node("Player/Camera").zoom = Vector2(1.8, 1.8)
		#else:
		#	GameManager.get_node("Player/Camera").zoom = Vector2(1.63, 1.63)
		#GameManager.get_node("Player").position = get_door(target_door).get_node("Spawn").global_position
		Player.position = get_door(target_door).get_node("Spawn").global_position
		await get_tree().create_timer(0.1).timeout
		Player.get_node("PlayerCamera").set_position_smoothing_enabled(true)

# locates the target door to spawn the player at
func get_door(door_name: String) -> Node2D: 
	for node in get_tree().current_scene.get_tree().get_nodes_in_group("doors"):
		if node.name == door_name:
			return node
	return null
	
# Plays the selected transition
func play_transition(time):
		var tween = get_tree().create_tween()
		var transition = get_node("Transitioner/Fade")
		tween.tween_property(transition, "material:shader_parameter/progress", 1, time)
		tween.tween_property(transition, "material:shader_parameter/progress", 1, time)
		tween.tween_property(transition, "material:shader_parameter/progress", 0, time)
