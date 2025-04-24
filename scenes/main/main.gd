extends Node2D

const TILE_SCALE: float = 0.25

@export var EmptyTileScene: PackedScene


func _ready() -> void:
    var background_tile: Node2D
    for x_index in range(4):
        for y_index in range(4):
            background_tile = EmptyTileScene.instantiate()
            background_tile.position = Vector2(5 + 105 * x_index, 5 + 105 * y_index)
            background_tile.scale = Vector2(TILE_SCALE, TILE_SCALE)
            $Background.add_child(background_tile)


func _on_update_timer_timeout() -> void:
    var new_tile_power = $NumberTile.tile_power + 1
    if new_tile_power > 16:
        new_tile_power = 1
    $NumberTile.update_tile_power(new_tile_power)
