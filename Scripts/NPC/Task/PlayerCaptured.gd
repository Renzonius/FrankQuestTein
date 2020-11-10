extends ConditionTask


func run(tick: Tick) -> int:
	if tick.blackboard.get("player_captured"): #si el jugador fue capturado
		return OK
	elif not tick.blackboard.get("player_captured"): #si el jugador no fue capturado
		return FAILED
	return ERR_BUG
