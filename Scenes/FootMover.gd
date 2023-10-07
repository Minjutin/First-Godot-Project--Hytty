extends Node

var childArray: Array

var i: int = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in self.get_node("Feet").get_children():
		childArray.append(_i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Player releases down button
	if Input.is_action_just_released("ui_down"):
		#Drop
		childArray[i].transport_in_drop()
		#Move to the next foot
		i=(i+1)%childArray.size()
	
	#Player presses up button
	if Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_down"):
		childArray[i].rise(delta)
		if i == 2:
			get_node("/root/HyttyGame/Camera2D").position.x = childArray[i].position.x

	#Player presses down button
	if Input.is_action_pressed("ui_down"):
		childArray[i].drop(delta)
	
		

		
