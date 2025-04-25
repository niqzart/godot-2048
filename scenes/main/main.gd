extends Node2D

@onready var game_controller: GameController = $GameController


func _ready() -> void:
    self.game_controller.spawn_random_tile()
    self.game_controller.spawn_random_tile()


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

    if self.game_controller.game_state.list_empty_cell_ids().size() != 0:
        self.game_controller.spawn_random_tile()
