extends Label

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

const STYLE_BOX_NAME: String = "normal"
const FONT_SIZE_NAME: String = "font_size"

var tile_power: int = 11


func update_tile_power(new_tile_power: int) -> void:
    self.tile_power = new_tile_power

    var tile_value: int = 2 ** self.tile_power
    self.text = str(tile_value)

    var font_size: int = FONT_SIZE_MAP[len(self.text)]
    self.add_theme_font_size_override(FONT_SIZE_NAME, font_size)

    var background_hue: float = 15 + self.tile_power * 20
    var stylebox: StyleBox = self.get_theme_stylebox(STYLE_BOX_NAME).duplicate()
    stylebox.bg_color.h = background_hue / 360
    self.add_theme_stylebox_override(STYLE_BOX_NAME, stylebox)
