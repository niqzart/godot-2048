extends Node2D

const FONT_SIZE_MAP: Dictionary = {  # [int, int]
    1: 220,
    2: 220,
    3: 180,
    4: 140,
    5: 120,
    6: 100,
    7: 85,
    8: 75,
}

const FONT_SIZE_NAME: String = "font_size"


func set_label_text(new_text: String) -> void:
    $Label.text = new_text

    var font_size: int = FONT_SIZE_MAP[len(new_text)]
    $Label.add_theme_font_size_override(FONT_SIZE_NAME, font_size)
