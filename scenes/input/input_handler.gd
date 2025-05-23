extends Control
class_name InputHandler

signal perform_game_move(direction: Vector2i)
signal restart_game()

enum ActionTypeEnum {RIGHT, LEFT, DOWN, UP, RESTART}


func handle_action_just_pressed(action_type: ActionTypeEnum) -> void:
    if action_type == ActionTypeEnum.RIGHT:
        self.perform_game_move.emit(Vector2i.RIGHT)
    elif action_type == ActionTypeEnum.LEFT:
        self.perform_game_move.emit(Vector2i.LEFT)
    elif action_type == ActionTypeEnum.DOWN:
        self.perform_game_move.emit(Vector2i.DOWN)
    elif action_type == ActionTypeEnum.UP:
        self.perform_game_move.emit(Vector2i.UP)


func handle_action_long_pressed(action_type: ActionTypeEnum) -> void:
    if action_type == ActionTypeEnum.RIGHT:
        self.perform_game_move.emit(Vector2i.RIGHT)
    elif action_type == ActionTypeEnum.LEFT:
        self.perform_game_move.emit(Vector2i.LEFT)
    elif action_type == ActionTypeEnum.DOWN:
        self.perform_game_move.emit(Vector2i.DOWN)
    elif action_type == ActionTypeEnum.UP:
        self.perform_game_move.emit(Vector2i.UP)


func handle_action_just_long_pressed(action_type: ActionTypeEnum) -> void:
    if action_type == ActionTypeEnum.RESTART:
        self.restart_game.emit()


# type: Dictionary[String, ActionTypeEnum]
var action_name_to_type: Dictionary = {
    "move_right": ActionTypeEnum.RIGHT,
    "move_left": ActionTypeEnum.LEFT,
    "move_down": ActionTypeEnum.DOWN,
    "move_up": ActionTypeEnum.UP,
    "restart": ActionTypeEnum.RESTART,
}

# type: Dictionary[ActionTypeEnum, int]
var action_type_to_hold_time: Dictionary = {
    ActionTypeEnum.RIGHT: 0,
    ActionTypeEnum.LEFT: 0,
    ActionTypeEnum.DOWN: 0,
    ActionTypeEnum.UP: 0,
    ActionTypeEnum.RESTART: 0,
}


const long_press_threshold: float = 0.5  # in seconds, same as delta


func is_action_long_pressed(action_type: ActionTypeEnum) -> bool:
    return self.action_type_to_hold_time[action_type] > self.long_press_threshold


func process_long_press(action_type: ActionTypeEnum, delta: float) -> void:
    var is_long_pressed_before: bool = self.is_action_long_pressed(action_type)

    self.action_type_to_hold_time[action_type] += delta

    if not self.is_action_long_pressed(action_type):
        return

    if is_long_pressed_before:
        self.handle_action_long_pressed(action_type)
    else:
        self.handle_action_just_long_pressed(action_type)


func process_action(action_name: String, delta: float) -> void:
    var action_type: ActionTypeEnum = action_name_to_type[action_name]
    if Input.is_action_just_pressed(action_name):
        self.handle_action_just_pressed(action_type)
    elif Input.is_action_pressed(action_name):
        self.process_long_press(action_type, delta)
    elif Input.is_action_just_released(action_name):
        self.action_type_to_hold_time[action_type] = 0


var starting_swipe_position  # type: Vector2 | null
const minimum_swipe_length: float = 50


func snap_to_cardinal_direction(vector: Vector2) -> Vector2i:
    return Vector2i(Vector2(1, 0).rotated(snapped(vector.angle(), PI / 2)))


func process_swipe() -> void:
    if self.starting_swipe_position == null:
        # swiped has already been recorded, so do nothing
        return

    var current_position: Vector2 = self.get_global_mouse_position()
    var swipe_vector: Vector2 = current_position - self.starting_swipe_position
    if swipe_vector.length() < self.minimum_swipe_length:
        return

    var swipe_direction: Vector2i = self.snap_to_cardinal_direction(swipe_vector)
    self.perform_game_move.emit(swipe_direction)
    self.starting_swipe_position = null


func process_touch() -> void:
    if Input.is_action_just_pressed("touch"):
        var mouse_position = self.get_global_mouse_position()
        if self.get_global_rect().grow(200).has_point(mouse_position):
            self.starting_swipe_position = mouse_position
    elif Input.is_action_pressed("touch"):
        self.process_swipe()
    elif Input.is_action_just_released("touch"):
        self.starting_swipe_position = null


func _process(delta: float) -> void:
    for action_name in action_name_to_type.keys():
        self.process_action(action_name, delta)
    self.process_touch()
