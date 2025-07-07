extends Label

var original_pos: Vector2
var airTime = 0.3
var groundTime = 0.2
var bounceTime = 0.03
var timesToBounce = 250
var shake = 2

func _ready() -> void:
	original_pos = position
	floatingNumber()


func floatingNumber() -> void:
	var floating = get_tree().create_tween()
	var offset = Vector2(0, -70) 
	floating.tween_property(self, "position", original_pos + offset, airTime).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	floating.tween_property(self, "position", original_pos, groundTime).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	for x in range(timesToBounce):
		offset = Vector2(0, randf_range(-shake, shake))
		floating.tween_property(self, "position", original_pos+ offset, bounceTime).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
