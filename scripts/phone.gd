extends Node3D

@onready var emmision: MeshInstance3D = $emmision
@onready var  player = get_node("/root/Main/player")
@onready var ring: AudioStreamPlayer = $ring
@onready var ended: AudioStreamPlayer = $ended

@onready var in_areaphone = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && in_areaphone:
		print("nophone")
		ring.stop()
		ended.play()
		emmision.visible = false
		player.done()

func playy():
	emmision.visible = true
	print("yesphone")
	ring.play()
	print("playing")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		in_areaphone = true
		player.label()


func _on_area_3d_body_exited(body: Node3D) -> void:
	in_areaphone = false
	player.label()
