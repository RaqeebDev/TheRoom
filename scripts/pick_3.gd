extends RigidBody3D

@export var max_torque: float = 1.0
@export var max_force: float = 0.5
@export var min_interval: float = 1.0
@export var max_interval: float = 3.0

var current_force: Vector3 = Vector3.ZERO
var current_torque: Vector3 = Vector3.ZERO

func _ready():
	randomize()
	_change_motion()

func _physics_process(delta: float) -> void:
	# Apply small continuous force and torque each physics frame
	apply_central_force(current_force)
	apply_torque(current_torque)

func _change_motion() -> void:
	# Random forward/backward + side movement (X/Z)
	current_force = Vector3(
		randf_range(-max_force, max_force),
		0,
		randf_range(-max_force, max_force)
	)

	# Random spin
	current_torque = Vector3(
		randf_range(-max_torque, max_torque),
		randf_range(-max_torque/2, max_torque/2),
		randf_range(-max_torque, max_torque)
	)

	# Schedule next change after random interval (makes natural pauses)
	var wait_time = randf_range(min_interval, max_interval)
	await get_tree().create_timer(wait_time).timeout
	_change_motion()
