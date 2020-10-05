extends KinematicBody2D

export (int) var rapidez = 300

var velocidad = Vector2()

func get_input():
	velocidad = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocidad.x += 1
	if Input.is_action_pressed('ui_left'):
		velocidad.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocidad.y += 1
	if Input.is_action_pressed('ui_up'):
		velocidad.y -= 1
	velocidad = velocidad.normalized() * rapidez

func _physics_process(delta):
	get_input()
	velocidad = move_and_slide(velocidad)
	

