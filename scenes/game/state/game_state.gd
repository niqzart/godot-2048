extends Node2D
class_name GameState

# type: Dictionary[Vector2i, NumberTile]
var cell_id_to_tile: Dictionary = {}

# type: Dictionary[Vector2i, null] (used as a Set)
var empty_cell_ids: Dictionary = {}


func add_empty_cell(cell_id: Vector2i) -> void:
    self.empty_cell_ids[cell_id] = null  # works like `Set.add`


func remove_empty_cell(cell_id: Vector2i) -> void:
    self.empty_cell_ids.erase(cell_id)  # works like `Set.remove`


func list_empty_cell_ids() -> Array:  # type: Array[Vector2i]
    return self.empty_cell_ids.keys()  # works like `Set.items`


func init_cells(board_shape: Vector2i) -> void:
    for x_index: int in range(board_shape.x):
        for y_index: int in range(board_shape.y):
            self.add_empty_cell(Vector2i(x_index, y_index))


func get_board_cell(cell_id: Vector2i) -> NumberTile:  # NumberTile | null
    return self.cell_id_to_tile.get(cell_id)


func set_board_cell(cell_id: Vector2i, tile: NumberTile) -> void:
    self.cell_id_to_tile[cell_id] = tile
    self.remove_empty_cell(cell_id)


func clear_board_cell(cell_id: Vector2i) -> void:
    self.cell_id_to_tile.erase(cell_id)
    self.add_empty_cell(cell_id)
