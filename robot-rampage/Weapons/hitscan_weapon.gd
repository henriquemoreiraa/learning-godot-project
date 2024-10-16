extends Node3D

@export var weapon_mesh: Node3D
@export var weapon_shoot_particles: GPUParticles3D
@export var sparks: PackedScene
@export var fire_rate: float
@export var recoil: float
@export var damage: float
@export var automatic: bool
@export var ammo_handler: AmmoHandler
@export var ammo_bullet: AmmoHandler.ammo_bullets

@onready var timer: Timer = $Timer
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var weapon_position: Vector3 = weapon_mesh.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if automatic:
		if Input.is_action_pressed("fire"):
			if timer.is_stopped():
				shoot()
	else:
		if Input.is_action_just_pressed("fire"):
			if timer.is_stopped():
				shoot()
				
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 10.0)
			
func shoot() -> void:
	if ammo_handler.has_ammo(ammo_bullet):
		ammo_handler.use_ammo(ammo_bullet)
		weapon_shoot_particles.restart()
		timer.start(1.0 / fire_rate)
		weapon_mesh.position.z += recoil
		
		if ray_cast_3d.is_colliding():			
			var spark := sparks.instantiate()
			add_child(spark)
			spark.global_position = ray_cast_3d.get_collision_point()
			
			var collider := ray_cast_3d.get_collider()
			
			if collider is Enemy:
				collider.hitpoint -= damage
	
