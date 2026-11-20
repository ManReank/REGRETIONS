
extends CharacterBody2D

@export var move_speed: float = 100.0

@onready var interaction_area: Area2D = $InteractionArea


func _ready() -> void:
	interaction_area.area_entered.connect(_on_area_entered)
	interaction_area.area_exited.connect(_on_area_exited)


func _physics_process(_delta: float) -> void:
	if DialogueManager.is_dialogue_active:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# Kode movement kamu yang sebelumnya tetap di bawah sini.
	var movement_direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
        "move_down"
	)

	velocity = movement_direction * move_speed
	move_and_slide()

	if Input.is_action_just_pressed("interact"):
		InteractionManager.interact()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("interact"):
		InteractionManager.set_nearby_object(area)


func _on_area_exited(area: Area2D) -> void:
	InteractionManager.clear_nearby_object(area)
