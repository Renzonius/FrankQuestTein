extends Decorator
class_name RepeatFailed,"res://Assets/Sprites/SpriteNodes/failer.png"

func run(tick : Tick) -> int:
	var result := ERR_BUG
	
	
	for child in get_children():
		result = child._execute(tick)
		
		while result == OK:
			result = child._execute(tick)
		
	return result
