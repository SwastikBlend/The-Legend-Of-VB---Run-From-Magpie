extends CharacterBody2D

var speed = 50
var health = 50
var direction = Vector2()
var change_direction_timer = 5.0

func _ready():
	add_to_group("enemy")
	choose_new_direction()
	set_process(true)
	randomize()
	
	
func _process(delta):
	change_direction_timer -= delta
	if change_direction_timer <= 0:
		choose_new_direction()
		change_direction_timer = 5.0
		
		
func _physics_process(delta):
	velocity = direction  * speed
	move_and_slide()
	
func choose_new_direction():
	var directions = [Vector2(1,0), Vector2(-1,0), Vector2(0,-1), Vector2(0,1)]
	var random_index = randi() % directions.size()
	direction = directions[random_index]
	update_animation()
	
	
func update_animation():
	if direction == Vector2(1,0):
		%PieAnimation.flip_h = false
		%PieAnimation.play("Right")
	elif direction == Vector2(-1,0):
		%PieAnimation.flip_h = true
		%PieAnimation.play("Right")
	elif direction == Vector2(0,-1):
		%PieAnimation.flip_h = false
		%PieAnimation.play("Up")
	elif direction == Vector2(0,1):
		%PieAnimation.flip_h = false
		%PieAnimation.play("Down")
	 
	
		  
