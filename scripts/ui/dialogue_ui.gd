
extends Control

@onready var dialogue_panel: PanelContainer = $DialoguePanel
@onready var dialogue_text: Label = $DialoguePanel/DialogueText


func _ready() -> void:
	dialogue_panel.hide()

	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_line_changed.connect(_on_dialogue_line_changed)
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)


func _unhandled_input(event: InputEvent) -> void:
	if not DialogueManager.is_dialogue_active:
		return

	if event.is_action_pressed("ui_accept"):
		DialogueManager.next_line()
		get_viewport().set_input_as_handled()


func _on_dialogue_started() -> void:
	dialogue_panel.show()


func _on_dialogue_line_changed(text: String) -> void:
	dialogue_text.text = text


func _on_dialogue_finished() -> void:
	dialogue_panel.hide()
