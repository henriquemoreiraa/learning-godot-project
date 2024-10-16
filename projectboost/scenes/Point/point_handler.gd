extends Node

class_name PointHandler

@onready var point_label: Label = $MarginContainer/PointLabel

var points: int:
	set(value):
		points = value
		point_label.text = "Points: " + str(points)

func _ready() -> void:
	points = 0
