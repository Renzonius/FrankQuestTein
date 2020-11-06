extends Decorator
class_name Failer,"res://Assets/Sprites/SpriteNodes/failer.png"


func run(tick:Tick) -> int:
	var child := get_child(0) 
	child._execute(tick)  #ACCIONES DEL HIJO
	
	return FAILED
