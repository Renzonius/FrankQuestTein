class_name TimerScript
extends Node2D

signal finished
var s : int = 60 setget  _set_seconds, _get_seconds

var label

func _ready() -> void:
	label = get_node("Timers/Label")


func _set_seconds(new_s : int):
	s = new_s

func _get_seconds() -> int:
	return s

func _on_Timer_timeout() -> void:
	if s > 0:
		s -= 1
		label.set_text(str(s))
	elif s <= 0:
		emit_signal("finished")
