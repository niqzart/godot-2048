extends Node2D
class_name InputHandler

signal perform_game_move(direction: Vector2i)


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("move_right"):
        self.perform_game_move.emit(Vector2i.RIGHT)
    elif event.is_action_pressed("move_left"):
        self.perform_game_move.emit(Vector2i.LEFT)
    elif event.is_action_pressed("move_down"):
        self.perform_game_move.emit(Vector2i.DOWN)
    elif event.is_action_pressed("move_up"):
        self.perform_game_move.emit(Vector2i.UP)
    else:
        return
