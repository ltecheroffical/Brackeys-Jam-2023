extends Node2D


func _enter_tree():
	RenderingServer.set_default_clear_color(Color.SKY_BLUE)


func _process(_delta):
	if $Player.position.y > $KillPlane.position.y:
		$Player.position = Vector2(0, -$KillPlane.position.y) # Sneaky
