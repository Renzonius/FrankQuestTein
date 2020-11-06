extends ConditionTask

func run(tick : Tick) -> int:
	if tick.blackboard.get("time_over"):
		print("Termino el tiempo")
		return OK
	elif not tick.blackboard.get("time_over"):
		return FAILED
	return ERR_BUG
