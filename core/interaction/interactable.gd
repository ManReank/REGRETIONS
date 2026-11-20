
extends Area2D

signal interacted(object_id: String)

@export var object_id: String = "unknown"
@export var interaction_text: String = "Periksa"


func interact() -> void:
	interacted.emit(object_id)
