extends ConditionTask

func run(tick : Tick) -> int:
	if tick.blackboard.get("chase_time_finished"):
		return FAILED
	elif not tick.blackboard.get("chase_time_finished"):
		return OK
	return ERR_BUG
