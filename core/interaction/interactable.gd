extends Area2D

signal interacted(object_id: String)

# Semua objek yang bisa diperiksa berada di layer 2.
# Area interaksi Eira mencari layer ini.
const INTERACTABLE_LAYER: int = 2

@export var object_id: String = "unknown"
@export var interaction_text: String = "Periksa"


func _ready() -> void:
	collision_layer = INTERACTABLE_LAYER
	collision_mask = 0


func interact() -> void:
	interacted.emit(object_id)
