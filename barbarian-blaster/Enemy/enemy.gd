extends PathFollow3D

@onready var base = get_tree().get_first_node_in_group("base")
@onready var bank = get_tree().get_first_node_in_group("bank")
@onready var animation_player: AnimationPlayer = $Barbarian/AnimationPlayer2

@export var speed := 2.5
@export var max_health := 50
@export var gold_per_enemy := 15

var current_health: int:
	set(health):
		if health < current_health:
			animation_player.play("take_damage")
		
		current_health = health
		
		if current_health < 1:
			queue_free()
			bank.current_gold += gold_per_enemy
			
func _ready() -> void:
	current_health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	progress += delta * speed
	
	if progress_ratio == 1.0:
		base.take_damage()
		set_process(false)
		queue_free()
