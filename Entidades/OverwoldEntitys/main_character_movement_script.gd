extends CharacterBody2D

@export var speed = 50

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down") 
	velocity = speed * input_vector
	move_and_slide()
