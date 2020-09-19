extends Sprite


var pos_planet = Vector2(140, 100)

# Called when the node enters the scene tree for the first time.
func _process(delta):
	pos_planet.x += 0.015
	pos_planet.y += 0.015
	
	position = pos_planet
