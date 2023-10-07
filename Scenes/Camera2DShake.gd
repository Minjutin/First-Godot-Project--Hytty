extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var shaking: float = 0.2
var shake_amount = 3.0
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _process(delta):
	if(shaking < 0.15):
		rng.randomize()
		set_offset(Vector2( \
			rng.randi_range(-1.0, 1.0) * shake_amount, \
			rng.randi_range(-1.0, 1.0) * shake_amount \
		))
		shaking = shaking + delta

func shake_effect():
	shaking = 0
