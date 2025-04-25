extends Node2D

@onready var game_controller: GameController = $GameController

var current_cell_id: Vector2 = Vector2(0, 0)
var number_tile: NumberTile


func _ready() -> void:
    self.number_tile = self.game_controller.create_tile(self.current_cell_id, 11)
    self.game_controller.create_tile(Vector2(1, 1), 11)


func _on_update_timer_timeout() -> void:
    self.current_cell_id.x += 1
    if self.current_cell_id.x > 3:
        self.current_cell_id.x = 0
        self.current_cell_id.y += 1
        if self.current_cell_id.y > 3:
            self.current_cell_id.y = 0

    var target_tile = game_controller.game_state.get_board_cell(self.current_cell_id)
    if target_tile == null:
        self.game_controller.move_tile(self.number_tile, self.current_cell_id)
    else:
        self.game_controller.merge_tiles(self.number_tile, target_tile)
