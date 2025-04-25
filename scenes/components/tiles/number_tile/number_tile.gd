extends Node2D
class_name NumberTile

var cell_id: Vector2 = Vector2(0, 0)
var tile_power: int = 11


func update_cell_id(new_cell_id: Vector2) -> void:
    self.cell_id = new_cell_id


func update_tile_power(new_tile_power: int) -> void:
    self.tile_power = new_tile_power

    var tile_value: int = 2 ** self.tile_power
    $TileLabel.set_label_text(str(tile_value))

    var background_hue: float = 15 + self.tile_power * 20
    $TileBackground.set_background_hue(background_hue)
