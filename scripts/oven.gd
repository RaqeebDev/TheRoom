extends Area3D

@onready var  player = get_node("/root/Main/player")
@onready var  phone = get_node("/root/Main/phone")

@onready var in_area_oven = false




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && in_area_oven == true:
			$Label3D.show()
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



@onready var cnt = 25;
func _on_oventimer_timeout() -> void:
	
	cnt-=1;
	$Label3D.text = str(cnt)
	print(cnt)
	if cnt == 0:
		$oventimer.stop()
		
		
		$ovensound.stop()
		$"Oven-timer-complete".play()
		$emmision.hide()
		$button.hide()
		await get_tree().create_timer(0.7).timeout
		$Label3D.hide()
		phone.used = false
		phone.play()
		
		cnt = 25
		
	
	
