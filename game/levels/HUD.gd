extends Control



func _ready() -> void:
	owner.get_parent().connect("timer_update", self, "_update_label_timer")
	owner.get_parent().connect("update_score", self, "_update_score")

func _update_label_timer(new_time : int):
	$Secons.set_text(str(new_time))
	
func _update_score(new_score : int):
	$Score.set_text("Score: "+ str(new_score))

