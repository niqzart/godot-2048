extends Node2D
class_name InputHandler

signal perform_game_move(direction: Vector2i)
signal restart_game()

enum ActionTypeEnum {RIGHT, LEFT, DOWN, UP, RESTART}


func handle_action_pressed(action_type: ActionTypeEnum) -> void:
    if action_type == ActionTypeEnum.RIGHT:
        self.perform_game_move.emit(Vector2i.RIGHT)
    elif action_type == ActionTypeEnum.LEFT:
        self.perform_game_move.emit(Vector2i.LEFT)
    elif action_type == ActionTypeEnum.DOWN:
        self.perform_game_move.emit(Vector2i.DOWN)
    elif action_type == ActionTypeEnum.UP:
        self.perform_game_move.emit(Vector2i.UP)
    elif action_type == ActionTypeEnum.RESTART:
        self.restart_game.emit()

# type: Dictionary[String, ActionTypeEnum]
var action_name_to_type: Dictionary = {
    "move_right": ActionTypeEnum.RIGHT,
    "move_left": ActionTypeEnum.LEFT,
    "move_down": ActionTypeEnum.DOWN,
    "move_up": ActionTypeEnum.UP,
    "restart": ActionTypeEnum.RESTART,
}


func _process(_delta: float) -> void:
    var action_type: ActionTypeEnum
    for action_name in action_name_to_type.keys():
        action_type = action_name_to_type[action_name]
        if Input.is_action_just_pressed(action_name):
            self.handle_action_pressed(action_type)
