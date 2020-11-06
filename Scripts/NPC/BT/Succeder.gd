extends Decorator
class_name Succeder, "res://Assets/Sprites/SpriteNodes/succeder.png"

func run(tick:Tick) -> int:
	var child := get_child(0)
	child._execute(tick) #ACCIONES DEL HIJO
	
	return OK
