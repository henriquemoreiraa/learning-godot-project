extends CanvasLayer

@onready var base = get_tree().get_first_node_in_group("base")
@onready var bank = get_tree().get_first_node_in_group("bank")
@onready var star_2: TextureRect = %Star2
@onready var star_3: TextureRect = %Star3
@onready var full_health: Label = %FullHealth
@onready var gold: Label = %Gold

func win_game() -> void:
	visible = true
	
	if base.current_health == base.max_health:
		star_2.modulate = Color.WHITE
		full_health.visible = true
		
	if bank.current_gold >= 500:
		star_3.modulate = Color.WHITE
		gold.visible = true
		

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
