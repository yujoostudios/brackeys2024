extends PanelContainer

@onready var texture_rect : TextureRect = $TextureRect
@onready var label : Label = $Label


func _on_necklace_money_change(count: int):
	label.text = str(int(label.text) + count)


func _on_scroll_money_change(count: int):
	label.text = str(int(label.text) + count)
