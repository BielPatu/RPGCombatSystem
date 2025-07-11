extends Label


var letter = ""
var textSpeed = 0.03


func animatedText(textToAnimate) -> void:
	letter = ""
	for x in len(textToAnimate):
		letter += str(textToAnimate[x])
		await get_tree().create_timer(textSpeed).timeout
		self.text = letter
	letter = ""
