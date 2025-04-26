extends Node2D

@onready var game_controller: GameController = $GameController
@onready var input_handler: InputHandler = $InputHandler


func _ready() -> void:
    self.game_controller.start_new_game()
    self.input_handler.perform_game_move.connect(self.game_controller.perform_game_move)
    self.input_handler.restart_game.connect(self.game_controller.start_new_game)


var directions: Array[Vector2i] = [
    Vector2i.RIGHT,
    Vector2i.DOWN,
    Vector2i.LEFT,
    Vector2i.UP,
]
var current_direction_index: int = 0


func _on_update_timer_timeout() -> void:
    if self.current_direction_index == 32:
        self.game_controller.start_new_game()
        self.current_direction_index = 0
    else:
        var direction = self.directions[self.current_direction_index % 4]
        self.game_controller.perform_game_move(direction)
        self.current_direction_index += 1
