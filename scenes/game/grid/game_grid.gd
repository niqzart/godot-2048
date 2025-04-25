extends Node2D
class_name GameGrid

const GAP_WIDTH: int = 5
const TILE_WIDTH: int = 100

@onready var board_background: Node2D = $Background

@export var GridCellBackgroundScene: PackedScene


func cell_id_to_position(cell_id: Vector2) -> Vector2:
    return Vector2(GAP_WIDTH, GAP_WIDTH) + (TILE_WIDTH + GAP_WIDTH) * cell_id


func add_cell_background(cell_id: Vector2, background: Node2D) -> void:
    background.position = self.cell_id_to_position(cell_id)
    self.board_background.add_child(background)


func create_grid_cell_backgrounds(board_shape: Vector2) -> void:
    for x_index in range(board_shape.x):
        for y_index in range(board_shape.y):
            self.add_cell_background(
                Vector2(x_index, y_index),
                GridCellBackgroundScene.instantiate(),
            )
