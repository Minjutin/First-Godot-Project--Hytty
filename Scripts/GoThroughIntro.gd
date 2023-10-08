extends Node

var sprite
var said

var images = [
	load("res://Art/Intro/intro0.png"),
	load("res://Art/Intro/intro1.png"),
	load("res://Art/Intro/intro2.png"),
	load("res://Art/Intro/intro3.png"),
	load("res://Art/Intro/intro4.png")
]

var textArray= [
	
	"When air gets colder\nDays get shorter\nWhen the summer ends\nThe inevitable impends\n\n[space]",
	"And the last protectors of human existence\nA vitally important assistance\nThe last living individuals\nCome to perform their rituals\n\n[space]",
	"It's said that they are useless\nThat they are simply just pests\nBut what they actually do\nIs working for the greater good\n\nThe blood is to be sacrificed\nTo our dreaded antichrist\nThey try to keep him satisfied\nAnd usually - he is pacified\n\n[space]",
	"But humans, they can't understand\nThey resist, they kill, they sabotage\nAnd this year's sacrifice\nJust doesn't seem to suffice\n\nIt's time to bid farewell\nTo human existence\n\n[space]",
	"Hytty awakens\n\n[space]"
	
]

var rng = RandomNumberGenerator.new()

var i: int = 0
var length: float = 0.0

var skip_letters = 0

func _ready():
	sprite  = get_node("IntroImage")
	said = get_node("Text")
	download_with_index(1)

# Go through
func _process(delta):
	
	download_with_index(i)


	if i==images.size()-1 && said.text.length() > 2  && said.text[said.text.length()-1] == "\n":
		length = length + 0.01
	elif said.text.length() > 2  && said.text[said.text.length()-1] == "\n":
		length = length + 0.03
	elif i == images.size()-1:
		length = length + 0.03
	else:
		length = length + 0.13
	
	if Input.is_action_just_pressed("ui_select") && length >= str(textArray[i]).length():
		length = 0
		i = i +1
	
		if i > images.size()-1:
			var simultaneous_scene = preload("res://Scenes/HyttyGame.tscn").instantiate()
			get_tree().root.add_child(simultaneous_scene)
			get_tree().root.remove_child(self)
			return
		
		#check if there is something else
		if i==1:
			said.position.y = 10
		if i>2:
			said.position.y = 280



func download_with_index(index):
	sprite.set_texture(images[index])
	var new_text = str(textArray[index]).substr(0,ceil(length))
	
	if(said.text.substr(said.text.length()-2,2)== "\n\n" && said.text.length() > str(textArray[index]).length()-15):
		said.text = str(textArray[index])
		length = str(textArray[index]).length()
		return
	
	if new_text > said.text && skip_letters < 0:
		get_node("Beep").pitch_scale = 1+rng.randf_range(0.1, 0.5)
		get_node("Beep").play()
		skip_letters =4
	
	said.text = new_text
	
	skip_letters = skip_letters-1
	
	
