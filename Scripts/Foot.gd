extends Sprite2D

var speed = 400
var origin_y

var step_sound

var has_been_transported: bool = false

func _ready():
	origin_y = position.y
	step_sound = self.get_parent().get_parent().get_node("Step")

func rise(delta):
	has_been_transported = false
	
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
	position.y = origin_y
	
	if(!has_been_transported):
		get_node("/root/HyttyGame/Camera2D").shake_effect()

		step_sound.position = self.position
		step_sound.play()

		
		has_been_transported = true
