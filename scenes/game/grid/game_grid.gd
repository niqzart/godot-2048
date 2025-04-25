extends Node2D
class_name GameGrid

const GAP_WIDTH: int = 5
const TILE_WIDTH: int = 100

@export var GridCellBackgroundScene: PackedScene


func cell_id_to_position(cell_id: Vector2i) -> Vector2:
    return Vector2i(GAP_WIDTH, GAP_WIDTH) + (TILE_WIDTH + GAP_WIDTH) * cell_id


func add_cell_background(cell_id: Vector2i, background: Node2D) -> void:
    background.position = self.cell_id_to_position(cell_id)
    self.add_child(background)


func create_grid_cell_backgrounds(board_shape: Vector2i) -> void:
    for x_index in range(board_shape.x):
        for y_index in range(board_shape.y):
            self.add_cell_background(
                Vector2i(x_index, y_index),
                GridCellBackgroundScene.instantiate(),
            )


func place_tile(cell_id: Vector2i, tile: NumberTile) -> void:
    tile.position = self.cell_id_to_position(cell_id)
