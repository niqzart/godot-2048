extends Node2D
class_name GameController

@onready var game_state: GameState = $GameState
@onready var game_grid: GameGrid = $GameGrid

var board_shape: Vector2 = Vector2(4, 4)


func _ready() -> void:
    self.game_state.init_cells(self.board_shape)
    self.game_grid.create_grid_cell_backgrounds(self.board_shape)


func add_tile(cell_id: Vector2, tile: NumberTile) -> void:
    self.game_state.set_board_cell(cell_id, tile)
    self.game_grid.place_tile(cell_id, tile)
    self.game_grid.add_child_tile(tile)


func move_tile(source_cell_id: Vector2, target_cell_id: Vector2) -> void:
    var tile = self.game_state.get_board_cell(source_cell_id)
    self.game_state.clear_board_cell(source_cell_id)
    self.game_state.set_board_cell(target_cell_id, tile)
    self.game_grid.place_tile(target_cell_id, tile)
