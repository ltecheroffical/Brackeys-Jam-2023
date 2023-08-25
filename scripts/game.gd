extends Node2D

var timer = 0.0


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.NAVY_BLUE)


func _process(delta: float) -> void:
	timer += delta
	$Node/SinWave.position.y = sin(timer) * 15
