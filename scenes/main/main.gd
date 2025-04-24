extends Node2D


func _on_update_timer_timeout() -> void:
    var new_tile_power = $Tile.tile_power + 1
    if new_tile_power > 16:
        new_tile_power = 1
    $Tile.update_tile_power(new_tile_power)
