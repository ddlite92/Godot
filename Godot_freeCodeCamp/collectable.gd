extends Node2D

var acorn = preload("res://Collectables/Acorn.tscn")



func _on_timer_timeout() -> void:
	var acornTemp = acorn.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(100, 410) 
	acornTemp.position = Vector2(ranint, 410)
	add_child(acornTemp)
