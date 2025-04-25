extends Node2D


func place_tile(tile: Node2D, x_index: int, y_index: int) -> void:
    tile.position = Vector2(5 + 105 * x_index, 5 + 105 * y_index)


var current_x_index: int = 0
var current_y_index: int = 0


func _on_update_timer_timeout() -> void:
    var new_tile_power = $NumberTile.tile_power + 1
    if new_tile_power > 16:
        new_tile_power = 1
    $NumberTile.update_tile_power(new_tile_power)

    self.current_x_index += 1
    if self.current_x_index > 3:
        self.current_x_index = 0
        self.current_y_index += 1
        if self.current_y_index > 3:
            self.current_y_index = 0
    self.place_tile($NumberTile, self.current_x_index, self.current_y_index)
