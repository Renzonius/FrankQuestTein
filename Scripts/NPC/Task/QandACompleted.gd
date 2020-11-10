extends ConditionTask

func run(tick: Tick) -> int:
	if not tick.blackboard.get("q_and_a_completed"): #si las preguntas no fueron contestadas
		return FAILED
	elif tick.blackboard.get("q_and_a_completed"): #si las preguntas fueron contestadas
#		print("preguntas contestadas")
		return OK
	return ERR_BUG
