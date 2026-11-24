
extends Node

signal nearby_object_changed(object: Area2D)
signal interaction_triggered(object_id: String)

var nearby_object: Area2D = null


func set_nearby_object(object: Area2D) -> void:
	nearby_object = object
	nearby_object_changed.emit(nearby_object)


func clear_nearby_object(object: Area2D) -> void:
	if nearby_object != object:
		return

	nearby_object = null
	nearby_object_changed.emit(null)


func interact() -> void:
	print("[DEBUG] interact() dipanggil, nearby_object = ", nearby_object)
	if nearby_object == null:
		return
		
	if not is_instance_valid(nearby_object):
		nearby_object = null
		nearby_object_changed.emit(null)
		return

	if nearby_object.has_method("interact"):
		nearby_object.interact()

		if "object_id" in nearby_object:
			interaction_triggered.emit(nearby_object.object_id)


func notify_interaction(object_id: String) -> void:
	interaction_triggered.emit(object_id)
