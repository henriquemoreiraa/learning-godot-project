extends Node3D

@export var bullet: PackedScene
@export var turret_range := 10.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cannon: Node3D = $TurretBase/TurretTop/TurretBarrel/Cannon
@onready var turret_base: MeshInstance3D = $TurretBase

var enemy_path: Path3D
var enemy_target: PathFollow3D

func _physics_process(delta: float) -> void:
	enemy_target = aim_best_target()
	
	if enemy_target:
		turret_base.look_at(enemy_target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if enemy_target:
		var new_bullet := bullet.instantiate()
		add_child(new_bullet)
		new_bullet.global_position = cannon.global_position

		new_bullet.direction = turret_base.global_transform.basis.z
		animation_player.play("shoot")

func aim_best_target() -> PathFollow3D:
	var best_target: PathFollow3D
	var best_progress: float
	
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			var distance = global_position.distance_to(enemy.global_position)
			
			if distance < turret_range and best_progress < enemy.progress:
			
				best_target = enemy
				best_progress = enemy.progress
	
	return best_target
