extends Node2D

@onready var game_controller: GameController = $GameController

var current_cell_id: Vector2 = Vector2(0, 0)


func _ready() -> void:
    self.game_controller.create_tile(self.current_cell_id, 11)
    self.game_controller.create_tile(Vector2(1, 1), 11)
    self.game_controller.create_tile(Vector2(0, 1), 11)
    self.game_controller.create_tile(Vector2(1, 0), 12)


var current_direction: Vector2 = Vector2(-1, 0)


func _on_update_timer_timeout() -> void:
    var starting_point: Vector2
    if self.current_direction.x == -1:
        starting_point = Vector2(3, 0)
    elif self.current_direction.x == 1:
        starting_point = Vector2(0, 3)
    elif self.current_direction.y == -1:
        starting_point = Vector2(3, 3)
    elif self.current_direction.y == 1:
        starting_point = Vector2(0, 0)

    self.game_controller.shift_row(starting_point, self.current_direction)
    self.current_direction = self.current_direction.rotated(deg_to_rad(90)).round()
