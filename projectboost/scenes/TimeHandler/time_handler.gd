extends Node

class_name TimeHandler

@onready var label: Label = $MarginContainer/Label

var current_time: float = 0.0

func _process(delta):
	current_time += delta
	label.text = "Time: " + str(int(current_time))
