extends CharacterBody2D

@export var move_speed: float = 100.0
# Sementara. Skala final ditentukan setelah ukuran ruangan dan kamera jelas.
@export var sprite_scale: float = 0.12

# Offset supaya kaki Eira tepat di titik (0, 0) node.
# Nilai = -(posisi kaki di sel 600x1400 - 700), diukur dari CHR-01_Eira.png.
const FEET_OFFSETS: Dictionary = {
	"down": Vector2(0, -546),
	"up": Vector2(0, -502),
	"left": Vector2(0, -509),
	"right": Vector2(0, -437),
}

var facing: String = "down"

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea


func _ready() -> void:
	interaction_area.area_entered.connect(_on_area_entered)
	interaction_area.area_exited.connect(_on_area_exited)

	sprite.scale = Vector2.ONE * sprite_scale
	_update_animation(false)


func _physics_process(_delta: float) -> void:
	if DialogueManager.is_dialogue_active:
		velocity = Vector2.ZERO
		move_and_slide()
		_update_animation(false)
		return

	var movement_direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = movement_direction * move_speed
	move_and_slide()

	var is_moving: bool = movement_direction != Vector2.ZERO
	if is_moving:
		_update_facing(movement_direction)
	_update_animation(is_moving)

	if Input.is_action_just_pressed("interact"):
		InteractionManager.interact()


func _update_facing(direction: Vector2) -> void:
	var has_horizontal: bool = absf(direction.x) > 0.01
	var has_vertical: bool = absf(direction.y) > 0.01

	var horizontal_facing: String = "right" if direction.x > 0.0 else "left"
	var vertical_facing: String = "down" if direction.y > 0.0 else "up"

	if has_horizontal and has_vertical:
		# Diagonal: pertahankan sumbu hadap sebelumnya supaya tidak berkedip.
		if facing == "left" or facing == "right":
			facing = horizontal_facing
		else:
			facing = vertical_facing
	elif has_horizontal:
		facing = horizontal_facing
	else:
		facing = vertical_facing


func _update_animation(is_moving: bool) -> void:
	var prefix: String = "walk_" if is_moving else "idle_"
	var animation_name: String = prefix + facing

	sprite.offset = FEET_OFFSETS[facing]
	if sprite.animation != animation_name:
		sprite.play(animation_name)


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("interact"):
		InteractionManager.set_nearby_object(area)


func _on_area_exited(area: Area2D) -> void:
	InteractionManager.clear_nearby_object(area)
