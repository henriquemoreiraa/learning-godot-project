extends Node3D

@onready var label_3d: Label3D = $Label3D

@export var max_health := 5

var current_health: int:
	set(health):
		current_health = health
		label_3d.text = str(current_health) + "/" + str(max_health)
		
		var red = Color.RED
		var white = Color.WHITE
		label_3d.modulate = red.lerp(white, float(current_health) / float(max_health))
		
		if current_health < 1:
			print("Game Over!")
			
			var tween = create_tween()
			tween.tween_interval(2.0)
			
			get_tree().reload_current_scene() 

func _ready() -> void:
	current_health = max_health
	
func take_damage() -> void:
	current_health -= 1
