extends Area3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.point_handler.points += 1
		animation_player.play("collect")
		audio_stream_player.play()
