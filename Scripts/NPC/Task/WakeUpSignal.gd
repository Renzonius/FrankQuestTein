extends ConditionTask

func run(tick: Tick) -> int:
	if not tick.blackboard.get("wake_up"):#si no es tiempo de despertar al npc
		return OK
	elif tick.blackboard.get("wake_up"):#si es tiempo de despertar al npc
		return FAILED
	return ERR_BUG
