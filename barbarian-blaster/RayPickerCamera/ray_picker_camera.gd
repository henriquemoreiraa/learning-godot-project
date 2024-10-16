extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bank := get_tree().get_first_node_in_group("bank")

@export var grid_map: GridMap
@export var turret_manager: Node3D
@export var turret_cost := 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position := get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 100.0
	ray_cast_3d.force_raycast_update()
		
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider() is GridMap and bank.current_gold >= turret_cost:	
		var cell_position := grid_map.local_to_map(ray_cast_3d.get_collision_point())
		var cell := grid_map.get_cell_item(cell_position)
		
		if cell == 0: 
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND) 
			if Input.is_action_just_pressed("click"):
				grid_map.set_cell_item(cell_position, 1)
				
				var tile_position := grid_map.map_to_local(cell_position)
				turret_manager.build_turret(tile_position)
				
				bank.current_gold -= turret_cost

		elif cell == 1:
			Input.set_default_cursor_shape(Input.CURSOR_FORBIDDEN)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW) 
			
