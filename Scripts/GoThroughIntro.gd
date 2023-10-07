extends Node

onready var sprite = get_node("roots/Text")
var introImages = [
	load("res://Art/Intro/intro2.png"),
	load("res://Art/Intro/intro3.png"),
	load("res://Art/Intro/intro4.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Go through
func startTutorial():

	
