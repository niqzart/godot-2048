extends Node2D
class_name GameController

@export var NumberTileScene: PackedScene

@onready var game_state: GameState = $GameState
@onready var game_grid: GameGrid = $GameGrid

var board_shape: Vector2 = Vector2(4, 4)


func _ready() -> void:
    self.game_state.init_cells(self.board_shape)
    self.game_grid.create_grid_cell_backgrounds(self.board_shape)


func create_tile(cell_id: Vector2) -> NumberTile:
    var tile: NumberTile = (NumberTileScene.instantiate() as NumberTile)
    self.game_state.set_board_cell(cell_id, tile)
    self.game_grid.place_tile(cell_id, tile)
    self.add_child(tile)
    return tile


func move_tile(source_tile: NumberTile, target_cell_id: Vector2) -> void:
    self.game_state.clear_board_cell(source_tile.cell_id)
    self.game_state.set_board_cell(target_cell_id, source_tile)
    self.game_grid.place_tile(target_cell_id, source_tile)
