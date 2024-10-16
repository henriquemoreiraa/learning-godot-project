extends Path3D

@onready var timer: Timer = $Timer

@export var enemy: PackedScene
@export var difficulty_manager: Node
@export var victory_layer: CanvasLayer

func spawn_enemy() -> void:
	var new_enemy := enemy.instantiate()
	new_enemy.max_health = difficulty_manager.get_enemy_health()
	add_child(new_enemy)
	
	new_enemy.tree_exited.connect(enemy_defeated)
	
	timer.wait_time = difficulty_manager.get_spawn_time()


func _on_difficulty_manager_stop_spawing_enemies() -> void:
	timer.stop()

func enemy_defeated() -> void:
	if timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D:
				return
		victory_layer.win_game()
