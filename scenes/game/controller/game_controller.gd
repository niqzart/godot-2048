extends Node2D

@onready var game_state: GameState = $GameState
@onready var game_grid: GameGrid = $GameGrid

var board_shape: Vector2 = Vector2(4, 4)


func _ready() -> void:
    self.game_grid.create_grid_cell_backgrounds(self.board_shape)
    self.game_state.init_cells(self.board_shape)
