extends Control

class_name VictoryLayer

@export_file("*.tscn") var next_level_file

@export var level: int
@export var time_achievement: int
@export var points_achievement: int

@onready var time_handler: TimeHandler = %TimeHandler
@onready var level_completed_label: Label = %LevelCompletedLabel
@onready var achievements_label: Label = %AchievementsLabel
@onready var time_achievement_label: Label = %TimeAchievementLabel
@onready var points_achievement_label: Label = %PointsAchievementLabel
@onready var point_handler: PointHandler = %PointHandler

func complete_level() -> void:
	time_handler.set_process(false)
	visible = true
	level_completed_label.text = "Level " + str(level) + " Completed!"
	
	time_achievement_label.text = "+ Time: " + str(int(time_handler.current_time)) + "/" + str(time_achievement)
	points_achievement_label.text = "+ Points: " + str(point_handler.points)  + "/" + str(points_achievement)
	
	if time_achievement >= int(time_handler.current_time):
		increase_achievements_completed()
		time_achievement_label.add_theme_color_override("font_color", Color.WHITE)
		
	if points_achievement == point_handler.points:
		increase_achievements_completed()
		points_achievement_label.add_theme_color_override("font_color", Color.WHITE)

func increase_achievements_completed() -> void:
	achievements_label.text[0] = str(int(achievements_label.text[0]) + 1)


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file(next_level_file)
