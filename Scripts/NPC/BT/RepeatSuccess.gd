extends Decorator
class_name RepeatSuccess,"res://Assets/Sprites/SpriteNodes/repeat.png"

func run(tick : Tick) -> int:
	var result := ERR_BUG
	
	
	for child in get_children():
		result = child._execute(tick)
		
		while result == FAILED:
			result = child._execute(tick)
		
	return result
