extends Sprite2D

var speed = 400
var origin_y

func _ready():
	origin_y = position.y

func rise(delta):
	var velocity = Vector2.ZERO
	velocity = Vector2.UP.rotated(rotation) * speed + Vector2.RIGHT.rotated(rotation)*speed
	position += velocity * delta
	if position.y < 0:
		position.y = 0

func drop(delta):
	var velocity = Vector2.ZERO
	velocity = -Vector2.UP.rotated(rotation) * speed

	position += velocity * delta
	
	if(position.y > origin_y):
		transport_in_drop()
		
func transport_in_drop():
	get_node("/root/HyttyGame/Camera2D").shake_effect()
	position.y = origin_y
