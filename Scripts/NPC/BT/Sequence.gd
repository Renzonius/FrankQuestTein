extends BehaviorBaseNode
class_name Sequence, "res://Assets/Sprites/SpriteNodes/sequence_icon.png"

func run(tick: Tick) -> int:
	var result := ERR_BUG # SI NO TIENE HIJOS
	
	for child in get_children():
		result = ERR_BUSY
		
		while result == ERR_BUSY:
			result = child._execute(tick)
	
		if result == FAILED:
			break
			
	return result
