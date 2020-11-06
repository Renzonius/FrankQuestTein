extends ConditionTask

func run(tick: Tick) -> int:
	if not tick.blackboard.get("patrol_time_finished"):
		return OK
	elif tick.blackboard.get("patrol_time_finished"):
		return FAILED
	return ERR_BUG
