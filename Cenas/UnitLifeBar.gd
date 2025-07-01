extends ProgressBar

var shake = 10
var shake_duration = 0.00009
var shake_count = 5000
var original_position: Vector2

func _ready():
	original_position = position

func shake_bar():
	var tween = get_tree().create_tween()
	for i in range(shake_count):
		var offset = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
		tween.tween_property(self, "position", original_position + offset, shake_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", original_position, shake_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
