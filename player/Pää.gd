extends Node3D

var mousey = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_x(mousey/-1000)
	mousey = 0

func _input(event):
	if event is InputEventMouseMotion:
		mousey = event.relative.y
