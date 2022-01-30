extends Node


func _ready():
	var dialog = Dialogic.start("Conversation1")
	add_child(dialog)
