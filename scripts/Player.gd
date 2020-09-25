extends KinematicBody2D


var motion = Vector2()
var gravity = 30
var UP = Vector2(0, -1)
const MAXVELOCITY = 400
const ACCELERATION = 30
var JUMP_FORCE = -800
var jump = false

var flip = false

var data = {
	"level" : Global.current_level
}


func save_game():
	var file = File.new()
	file.open(Global.save_path, File.WRITE)
	file.store_var(data)
	file.close()

func _process(delta):
	if Input.is_action_just_pressed("save_teste"):
		save_game()
		
	
	if Input.is_action_just_pressed("invert_gravity"):
		gravity *= -1
		flip = !flip
		
		if flip == true:
			$invert.play()
			UP = Vector2(0, 1)
			JUMP_FORCE = 800
		else:
			$gravity.play()
			UP = Vector2(0, -1)
			JUMP_FORCE = -800
		
		$Sprite.flip_v = flip
		
		

func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAXVELOCITY)
		$Sprite.flip_h = false
		$Sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAXVELOCITY)
		$Sprite.flip_h = true
		$Sprite.play("run")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$Sprite.play("idle")
		
	if is_on_floor():
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("jump_a"):
			motion.y = JUMP_FORCE
			$jump.play()
			
	else:
		if motion.y < 0:
			$Sprite.play("jump")
			
		else:
			$Sprite.play("fall")
		motion.x = lerp(motion.x, 0, 0.05)
	
	
	
	motion = move_and_slide(motion, UP)


"""
	FUNÇÕES CUSTOMIZADAS
"""

func morte():
	$death.play()
	position = Vector2(128, 920)


"""
	CONEXÕES
"""

#func _on_morte_body_entered(body):
#	if body == get_parent().get_node("Player"):
#		morte()


func _on_morte_body_entered(body):
	morte()
