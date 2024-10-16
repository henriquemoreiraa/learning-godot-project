extends Area3D

@export var ammo_bullet: AmmoHandler.ammo_bullets
@export var ammo_quantity := 20

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.ammo_handler.add_ammo(ammo_bullet, ammo_quantity)
		queue_free()
