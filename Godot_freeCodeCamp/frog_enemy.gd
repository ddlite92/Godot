extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting('physics/2d/default_gravity')
# @onready var anim = get_node("AnimatedSprite2D")
var player
var chase = false
#func _physics_process(delta: float) -> void:
func _ready():
	get_node("AnimatedSprite2D").play('Idle')
func _physics_process(delta):
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	velocity.y += gravity * delta
	if chase == true:
		if get_node('AnimatedSprite2D').animation != 'Death':
			#get_node('AnimatedSprite2D').play('Jump')
			get_node("AnimatedSprite2D").play('Jump')
		player = get_node("../../Player/Player") 
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node('AnimatedSprite2D').flip_h = true
		else:
			get_node('AnimatedSprite2D').flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if get_node('AnimatedSprite2D').animation != 'Death':
		#if anim.play('').animation != 'Death'
			get_node("AnimatedSprite2D").play('Idle')
			velocity.x = 0
	move_and_slide()
	
func _on_player_chase_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		chase = true

func _on_player_chase_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		chase = false

func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		death()

func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		Game.playerHP -= 1

func death():
	# Game.Gold += 3
	Utils.saveGame()
	chase = false
	get_node("AnimatedSprite2D").play('Death')
	#await anim.animation_finished
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
