extends CanvasLayer

@onready var game_controller: GameController = $GameContainer/GameController
@onready var input_handler: InputHandler = $GameContainer/InputHandler


func _ready() -> void:
    self.game_controller.start_new_game()
    self.input_handler.perform_game_move.connect(self.game_controller.perform_game_move)
    self.input_handler.restart_game.connect(self.game_controller.start_new_game)
