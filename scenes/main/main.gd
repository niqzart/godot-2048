extends Node2D

@onready var game_controller: GameController = $GameController

var current_cell_id: Vector2 = Vector2(0, 0)


func _ready() -> void:
    self.game_controller.add_tile(self.current_cell_id, $NumberTile)


func _on_update_timer_timeout() -> void:
    var new_tile_power = $NumberTile.tile_power + 1
    if new_tile_power > 16:
        new_tile_power = 1
    $NumberTile.update_tile_power(new_tile_power)

    var source_cell_id = self.current_cell_id

    self.current_cell_id.x += 1
    if self.current_cell_id.x > 3:
        self.current_cell_id.x = 0
        self.current_cell_id.y += 1
        if self.current_cell_id.y > 3:
            self.current_cell_id.y = 0

    self.game_controller.move_tile(source_cell_id, self.current_cell_id)
