extends Node2D


func _on_update_timer_timeout() -> void:
    var new_tile_power = $NumberTile.tile_power + 1
    if new_tile_power > 16:
        new_tile_power = 1
    $NumberTile.update_tile_power(new_tile_power)
