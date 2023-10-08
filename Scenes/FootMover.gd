extends Node

var child_array: Array

var i: int = 0

var movement_on: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in self.get_node("Feet").get_children():
		child_array.append(_i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Player releases down button
	if Input.is_action_just_released("ui_down") && movement_on:
		#Drop
		child_array[i].transport_in_drop()
		#Move to the next foot
		i=(i+1)%child_array.size()
	
	#Player presses up button
	if Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_down") && movement_on:
		
		#edit start sign if y is big enoguh
		if child_array[i].position.y < 10 :
			get_node("/root/HyttyGame/Sign").change_frame(1)
		
		if child_array[i].max_x <= child_array[i].position.x && child_array[i].position.y == child_array[i].origin_y:
			i=(i+1)%child_array.size()
			check_if_every_feet_placed()
		else:
			child_array[i].rise(delta)
			
			var avg_x: float = 0
			
			for foot in child_array:
				avg_x = avg_x+foot.position.x

			if avg_x/child_array.size() > get_node("/root/HyttyGame/Camera2D").position.x :
				get_node("/root/HyttyGame/Camera2D").position.x = avg_x/child_array.size()

	#Player presses down button
	if Input.is_action_pressed("ui_down") && movement_on:
		get_node("/root/HyttyGame/Sign").change_frame(0)
		child_array[i].drop(delta)

#Check if every feet is places
func check_if_every_feet_placed():
	var is_finished: bool = true
	for foot in child_array:
		if foot.position.x < foot.max_x:
			is_finished = false
	
	if is_finished:
		movement_on = false
		get_node("/root/HyttyGame").start_endgame()

		
