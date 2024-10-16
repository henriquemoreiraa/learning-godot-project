extends Node

class_name AmmoHandler

@export var ammo_label: Label 
@export var weapon_handler: Node3D

enum ammo_bullets {
	BULLET,
	SMALL_BULLET
}

var ammo_quantity := {
	ammo_bullets.BULLET: 10,
	ammo_bullets.SMALL_BULLET: 60,
}

func has_ammo(ammo_type: ammo_bullets) -> bool:
	return ammo_quantity[ammo_type] > 0

func use_ammo(ammo_type: ammo_bullets) -> void:
	if has_ammo(ammo_type):
		ammo_quantity[ammo_type] -= 1
		update_ammo_label(ammo_type)
		
func add_ammo(type: ammo_bullets, quantity: int) -> void:
	ammo_quantity[type] += quantity
	update_ammo_label(type)

func update_ammo_label(ammo_type: ammo_bullets) -> void:
	if weapon_handler.get_current_weapon() == ammo_type:
		ammo_label.text = str(ammo_quantity[ammo_type])
