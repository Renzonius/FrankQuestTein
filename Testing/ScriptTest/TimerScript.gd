extends Label

var s : int = 60 setget  _set_seconds, _get_seconds




func _set_seconds(new_s : int):
	s = new_s

func _get_seconds() -> int:
	return s

func _on_Timer_timeout() -> void:
	if s > 0:
		s -= 1
		set_text(str(s))
	else:
#		señal de perdiste
		print("Perdiste")
