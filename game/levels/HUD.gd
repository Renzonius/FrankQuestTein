extends Control

var lvl

func _ready() -> void:
	owner.connect("timer_update", self, "_update_label_timer")

func _update_label_timer(new_time : int):
	$Label.set_text(str(new_time))
