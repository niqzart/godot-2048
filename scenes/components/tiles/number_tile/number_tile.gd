extends Node2D
class_name NumberTile

var power: int = 11


func update_power(new_power: int) -> void:
    self.power = new_power

    $TileLabel.set_label_text(str(2 ** self.power))

    var background_hue: float = 15 + self.power * 20
    $TileBackground.set_background_hue(background_hue)


func increment_power() -> void:
    self.update_power(self.power + 1)
