extends Node2D

const STYLE_BOX_NAME: String = "panel"


func set_background_hue(new_hue: int) -> void:
    var stylebox: StyleBox = $Background.get_theme_stylebox(STYLE_BOX_NAME).duplicate()
    stylebox.bg_color.h = new_hue / 360.0
    $Background.add_theme_stylebox_override(STYLE_BOX_NAME, stylebox)
