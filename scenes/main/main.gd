extends Node2D

@onready var game_controller: GameController = $GameController

var current_cell_id: Vector2i = Vector2i(0, 0)


func _ready() -> void:
    self.game_controller.create_tile(self.current_cell_id, 11)
    self.game_controller.create_tile(Vector2i(1, 1), 11)
    self.game_controller.create_tile(Vector2i(0, 1), 11)
    self.game_controller.create_tile(Vector2i(1, 0), 12)


var directions: Array[Vector2i] = [
    Vector2i.RIGHT,
    Vector2i.DOWN,
    Vector2i.LEFT,
    Vector2i.UP,
]
var current_direction_index: int = 0


func _on_update_timer_timeout() -> void:
    var direction = self.directions[self.current_direction_index]
    self.game_controller.shift_board(direction)

    self.current_direction_index += 1
    self.current_direction_index %= 4
