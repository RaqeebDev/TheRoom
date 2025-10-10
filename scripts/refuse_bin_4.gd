extends Area3D
@onready var  player = get_node("/root/Main/player")

@onready var count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("pickable"):
		count = count + 1
		player.change("Dispose the Cans %d/4 " % count )
		body.queue_free()
		if count == 4:
			pass
			
