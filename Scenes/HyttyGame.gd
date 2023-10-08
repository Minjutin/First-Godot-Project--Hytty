extends Node2D

var camera_lerp : bool = false
var trunk_can_move : bool = true


var camera_og_position_x
var trunk_og_position

var t = 0.0
var t_trunk = 0.0

var trunk

var rng = RandomNumberGenerator.new()

var trunk_time = 0.0

func _ready():
	trunk = get_node("Hytty/Trunk")

func _process(delta):
	
	#Play
	if get_node("Camera2D/bgNoise").playing == false:
			get_node("Camera2D/bgNoise").play() 
	
	#After end game has started, lerp camera first
	if camera_lerp:
		t += delta*0.3
		if get_node("Camera2D").position.x > 5869:
			camera_lerp = false
			t = 1
		get_node("Camera2D").position.x = lerp(float(camera_og_position_x), float(5870), t)
		
	#After camera has lerped into the position, drop the trunk
	if get_node("Camera2D").position.x > 5800:
	
		if trunk.position.x >= 5900 && trunk.position.y >= 212 && trunk_can_move:
			
			var step_sound = get_node("/root/HyttyGame/Hytty/Step")
			step_sound.position.x = trunk.position.x
			step_sound.play()
			t_trunk = 1
			trunk_can_move = false
		elif trunk_can_move:
			t_trunk += delta*0.4
		trunk.position.x = lerp(float(trunk_og_position.x), 5900.0, t_trunk)
		trunk.position.y = lerp(float(trunk_og_position.y), 212.0, t_trunk) 

	#start sucking
	if trunk.position.x >= 5900:
		trunk.play()
		
		if trunk.frame == 1 && get_node("Hytty/Trunk/Slurp").playing == false:
			get_node("Hytty/Trunk/Slurp").pitch_scale = 1+rng.randf_range(-0.3, 0.3)
			get_node("Hytty/Trunk/Slurp").play()

	#end screen on
	if trunk.is_playing():
		trunk_time = trunk_time + delta
		if trunk_time > 8:
			get_node("EndScreen/Endscreen").visible = true
			get_node("EndScreen/Text").visible = true
			#get_node("Camera2D/bgNoise").stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func start_endgame():
	trunk_og_position = trunk.position
	trunk.frame = 0
	camera_og_position_x = get_node("Camera2D").position.x
	camera_lerp = true

