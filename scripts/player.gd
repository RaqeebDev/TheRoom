extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.8
const SENSITIVITY = 0.004

# Bob variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

# FOV variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

var gravity = 9.8

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var tasks: Label = $tasks
@onready var timer: Timer = $"../Timer"
@onready var  audiocan = get_node("/root/Main/pick/cansound")
@onready var  audiocan2 = get_node("/root/Main/pick/cansound")
@onready var  audiocan3 = get_node("/root/Main/pick/cansound")
@onready var tv = get_node("/root/Main/Tv")
@onready var  can = get_node("/root/Main/pick")

# Pickable system
@export_category("Pickable System")
var picked_object: RigidBody3D = null
@export var base_throw_strength: float = 20.0
@onready var pickup_raycast = $Head/Camera3D/RayCast3D
@onready var pickup_hand = $Head/Camera3D/hand



@onready var main: Node3D = $".."

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:		
	if event.is_action_pressed("interact"):
		if picked_object:
			drop_object()
			
			$can.play()
			
			await get_tree().create_timer(0.5).timeout
			
		else:
			var object = pickup_raycast.get_collider()
			if object and object.is_in_group("pickable"):
				pick_up_object(object)
	#elif event.is_action_pressed("throw") and picked_object:
		#throw_object()
		#
		#audiocan.play()
		#
		#await get_tree().create_timer(0.5).timeout
		#
		
		

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	var input_dir = Input.get_vector("right", "left", "forward", "backward")
	var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			
		else:
			$foot.play()
			velocity.x = lerp(velocity.x, 0.0, delta * 7.0)
			velocity.z = lerp(velocity.z, 0.0, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	# FOV effect
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody3D:
			var push_dir = -collision.get_normal()
			collider.apply_impulse(Vector3.ZERO, push_dir * 2.5)

	
	move_and_slide()

# UI & game logic functions
func change(texty):
	tasks.text = texty

func done():
	timer.start()

func label():
	$Label.visible = !$Label.visible

func breath():
	$breath.play()

func _on_timer_timeout() -> void:
	$"../light".visible = false
	tv.playtv()
	$sus.play()
	
	#tv.intphone()
	
	


#pickup/throw
func pick_up_object(object: RigidBody3D):
	if not object or not object.is_inside_tree():
		return

	if pickup_hand and pickup_hand.is_inside_tree():
		if object.get_parent():
			var saved_transform = object.global_transform
			object.get_parent().remove_child(object)

			picked_object = object
			picked_object.linear_velocity = Vector3.ZERO
			picked_object.angular_velocity = Vector3.ZERO
			picked_object.sleeping = true
			picked_object.freeze = true

			pickup_hand.add_child(picked_object)

			# Calculate position and rotation relative to hand
			picked_object.transform.origin = pickup_hand.to_local(saved_transform.origin)
			picked_object.transform.basis = pickup_hand.global_transform.basis.inverse() * saved_transform.basis

			print("[DEBUG] Picked up:", picked_object.name)
	else:
		return


func drop_object():
	if picked_object:
		var world = get_tree().current_scene
		var saved_transform = picked_object.global_transform
		
		pickup_hand.remove_child(picked_object)
		world.add_child(picked_object)
		picked_object.global_transform = saved_transform
		
		picked_object.freeze = false
		picked_object.sleeping = false
		picked_object.linear_velocity = Vector3.ZERO
		picked_object.angular_velocity = Vector3.ZERO
		picked_object = null

func throw_object():
	if picked_object:
		var world = get_tree().current_scene
		var saved_transform = picked_object.global_transform
		
		pickup_hand.remove_child(picked_object)
		world.add_child(picked_object)
		picked_object.global_transform = saved_transform
		
		picked_object.freeze = false
		picked_object.sleeping = false
		
		var throw_dir = -camera.global_transform.basis.z.normalized()
		var scaled_strength = base_throw_strength / max(1.0, picked_object.mass)
		picked_object.linear_velocity = throw_dir * scaled_strength
		
		print("[DEBUG] Threw object with velocity:", picked_object.linear_velocity)
		picked_object = null
