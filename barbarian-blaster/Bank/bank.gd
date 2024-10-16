extends MarginContainer

@onready var label: Label = $Label

@export var start_gold := 150.0

var current_gold: float:
	set(gold):
		current_gold = max(gold, 0)
		label.text = "Gold: " + str(current_gold)

func _ready() -> void:
	current_gold = start_gold
	
