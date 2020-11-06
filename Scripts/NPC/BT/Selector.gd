extends BehaviorBaseNode
class_name Selector,"res://Assets/Sprites/SpriteNodes/selector_icon.png"



func run(tick:Tick) -> int:
	var result := ERR_BUG # Si no tiene hijos
	
	for child in get_children():
		result = ERR_BUSY
		
		while result == ERR_BUSY:
			result = child._execute(tick)
			
		if result == OK:
			break
	
	return result
