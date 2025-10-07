extends Area3D

@onready var  player = get_node("/root/Main/player")

@onready var in_area_oven = false




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && in_area_oven == true:
			$emmision.show()
			$button.show()
			$ovensound.play()
			$oventimer.start()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		in_area_oven = true
		player.label()
		
		
		
		


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		in_area_oven = false
		player.label()


func _on_oventimer_timeout() -> void:
	$ovensound.stop()
	$"Oven-timer-complete".play()
	$emmision.hide()
	$button.hide()
