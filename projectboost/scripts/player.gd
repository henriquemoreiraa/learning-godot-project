extends RigidBody3D 

class_name Player

@export var thrust: float = 1000.0
@export var torque_thrust: float = 100.0

@onready var explosion_audio: AudioStreamPlayer = $Ship/Audios/ExplosionAudio
@onready var success_audio: AudioStreamPlayer = $Ship/Audios/SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $Ship/Audios/RocketAudio
@onready var booster_particles: GPUParticles3D = $Ship/Particles/BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $Ship/Particles/RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $Ship/Particles/LeftBoosterParticles
@onready var explosion_particles: GPUParticles3D = $Ship/Particles/ExplosionParticles
@onready var success_particles: GPUParticles3D = $Ship/Particles/SuccessParticles
@onready var timer: Timer = $Timer
@onready var label_3d: Label3D = $Label3D
@onready var point_handler: PointHandler = %PointHandler
@onready var victory_layer: VictoryLayer = %VictoryLayer

const CRASH_ROTATION = 26
const STANDING_ROTATION = -1

var transitioning := false

func _process(delta: float) -> void:
	var move_up := Input.is_action_pressed("move_up")
	var move_left := Input.is_action_pressed("move_left")
	var move_right := Input.is_action_pressed("move_right")
	
	# Vertical movement
	if move_up:
		booster_particles.emitting = true
		apply_central_force(basis.y * delta * thrust)
	else:
		booster_particles.emitting = false
	
	# Rotation movement
	right_booster_particles.emitting = move_left
	left_booster_particles.emitting = move_right
	
	if move_left:
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))
	elif move_right:
		apply_torque(Vector3(0.0, 0.0, -(torque_thrust * delta)))

	_handle_rocket_audio(move_up)


func _handle_rocket_audio(move_up: bool) -> void:
	if move_up:
		if not rocket_audio.playing:
			rocket_audio.play()
	else:
		if rocket_audio.playing:
			rocket_audio.stop()


func _physics_process(_delta: float) -> void:
	if not timer.is_stopped():
		label_3d.visible = true
		label_3d.text = str(int(timer.time_left))


func _on_body_entered(body: Node) -> void:
	if transitioning:
		return 

	if body.is_in_group("Goal"):
		if abs(rotation_degrees.x) >= CRASH_ROTATION:
			crash_sequence()
			return
		
		set_process(false)
		timer.start(3.5)
		timer.timeout.connect(complete_level)
	elif body.is_in_group("Lose"):
		crash_sequence()
		


func crash_sequence() -> void:
	explosion_particles.emitting = true
	explosion_audio.play()

	var tween = tween_and_stop(2.5)
	tween.tween_callback(get_tree().reload_current_scene)


func complete_level() -> void:
	var tween = tween_and_stop(1)

	if int(rotation_degrees.x) == STANDING_ROTATION:
		success_particles.emitting = true
		success_audio.play()
		tween.tween_callback(victory_layer.complete_level)
	else:
		crash_sequence()


func tween_and_stop(time: float) -> Tween:
	set_process(false)
	transitioning = true

	var tween = create_tween()
	tween.tween_interval(time)
	
	return tween
