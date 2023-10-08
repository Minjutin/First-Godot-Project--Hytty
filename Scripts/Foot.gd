extends Sprite2D

@export var max_x: int

var speed = 400
var origin_y

var step_sound

var has_been_transported: bool = false

var rng = RandomNumberGenerator.new()

func _ready():
	origin_y = position.y
	step_sound = self.get_parent().get_parent().get_node("Step")

func rise(delta):
	has_been_transported = false
	
	var velocity = Vector2.ZERO
	velocity = Vector2.UP.rotated(rotation) * speed + Vector2.RIGHT.rotated(rotation)*speed
	position += velocity * delta
	
	#Ensure that foot will not go too high
	if position.y < 0:
		position.y = 0
		
	#Ensure that foot will not go too far away
	if max_x < position.x:
		position.x = max_x
	

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
		step_sound.pitch_scale = 1+rng.randf_range(-0.2, 0.2)
		step_sound.play()

		
		has_been_transported = true
