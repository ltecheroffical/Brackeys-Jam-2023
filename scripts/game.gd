extends Node2D


func _process(_delta):
	if $Player.position.y > $KillPlane.position.y:
		$Player.position = Vector2.ZERO
