extends Area2D 

# SETUP GUIDE: Set "target_scene" to exact name of scene. Set "target_door" to exact name of door. 
# Door names should follow this example: Patio_A for the door entered first, and Patio_B for the other.
# The "Spawn" node should be positioned 60 pixels in the direction the player walks out from

class_name SceneDoor

@export var target_scene = "DEFAULT"
@export var target_door: String

@onready var spawn = $Spawn
var can_use = false

func _ready():
	await get_tree().create_timer(0.3).timeout
	can_use = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_use == true:
		SceneManager.call_deferred("go_to_level", target_scene, target_door)
