extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	printmanytimes(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func printmanytimes(number: int) -> void:
	var josef = Character
	
	for i in range(number):
		print(number)
		
class Character:
	var something: int
