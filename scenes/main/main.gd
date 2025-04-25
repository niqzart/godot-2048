extends Node2D

@onready var game_controller: GameController = $GameController

var current_cell_id: Vector2 = Vector2(0, 0)
var number_tile: NumberTile


func _ready() -> void:
    self.number_tile = self.game_controller.create_tile(self.current_cell_id)


func _on_update_timer_timeout() -> void:
    var new_tile_power = self.number_tile.tile_power + 1
    if new_tile_power > 16:
        new_tile_power = 1
    self.number_tile.update_tile_power(new_tile_power)

    self.current_cell_id.x += 1
    if self.current_cell_id.x > 3:
        self.current_cell_id.x = 0
        self.current_cell_id.y += 1
        if self.current_cell_id.y > 3:
            self.current_cell_id.y = 0

    self.game_controller.move_tile(self.number_tile, self.current_cell_id)
