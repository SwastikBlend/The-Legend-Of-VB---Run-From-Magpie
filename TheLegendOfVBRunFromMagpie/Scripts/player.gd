extends CharacterBody2D

const SPEED = 100
var last_direction = Vector2()
var health = 100
var is_dead = false
func _ready() -> void:
	add_to_group("player")

func _physics_process(delta):
	if is_dead:
		return
	update_health()
	var direction = Input.get_vector("ui_left" , "ui_right" , "ui_up" , "ui_down")
	velocity = direction * SPEED
	if direction != Vector2.ZERO:
		last_direction = direction.normalized()
		update_animation(direction)
	else:
		update_idle_animation()
		
	%AnimatedSprite2D.flip_h = last_direction.x < 0
	
	move_and_slide()
	
	
func update_animation(direction):
	if direction.x != 0:
		$%AnimatedSprite2D.play("Walk_Right")
	elif direction.y > 0:
		$AnimatedSprite2D.play("Walk_Down")
	elif direction.y < 0:
		$AnimatedSprite2D.play("Walk_Up")
		
		
func update_idle_animation():
	if last_direction.x != 0:
		$AnimatedSprite2D.play("Idle_Right")
	elif last_direction.y > 0:
		$AnimatedSprite2D.play("Idle_Down")
	elif last_direction.y < 0:
		$AnimatedSprite2D.play("Idle_Up")
		
func update_health():
	%HealthBar.value = health
		
	
	 
func deduct_health(amount):
	health -= amount
	if health < 0:
		health = 0
		update_health()
	if health == 0 and not is_dead : 
		handle_death()
		
		
func handle_death():
	is_dead = true
	%AnimatedSprite2D.play("Die") 
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		deduct_health(10)
		



func _on_animated_sprite_2d_animation_finished() -> void:
	var anim_name = %AnimatedSprite2D.animation
	if anim_name == "Die" :
		get_tree().reload_current_scene()
