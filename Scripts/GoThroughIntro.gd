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
	
	"When air gets colder\nDays get shorter\nWhen the summer ends\nThe inevitable impends",
	"And the last protectors of human existence\nA vitally important assistance\nThe last living individuals\nCome to perform their rituals",
	"It's said that they are useless\nThat they are simply just pests\nBut what they actually do\nIs working for the greater good\n\nThe blood is to be sacrificed\nTo our dreaded antichrist\nThey try to keep him satisfied\nAnd usually - he is pacified",
	"But humans, they can't understand\nThey resist, they kill, they sabotage\nAnd this year's sacrifice\nJust doesn't seem to suffice\n\nIt's time to bid farewell\nTo human existence",
	"Hytty awakens…"
	
]

var i: int = 0

func _ready():
	sprite  = get_node("IntroImage")
	said = get_node("Text")
	download_with_index(0)

# Go through
func _process(delta):
	
	if Input.is_action_just_pressed("ui_select"):
		
		i = i +1
	
		if i > images.size()-1:
			var simultaneous_scene = preload("res://Scenes/HyttyGame.tscn").instantiate()
			get_tree().root.add_child(simultaneous_scene)
			get_tree().root.remove_child(self)
			return
			
		download_with_index(i)
		
		#check if there is something else
		if i==1:
			said.position.y = -20
		if i>2:
			said.position.y = 280
			
	

func download_with_index(index):
	sprite.set_texture(images[index])
	said.text = str(textArray[index])
