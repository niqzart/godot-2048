extends Node2D
class_name GameController

@export var NumberTileScene: PackedScene

@onready var game_state: GameState = $GameState
@onready var game_grid: GameGrid = $GameGrid

var board_shape: Vector2 = Vector2(4, 4)


class TileRef:
    var cell_id: Vector2
    var tile: NumberTile

    func _init(cell_id_: Vector2, tile_: NumberTile) -> void:
        self.cell_id = cell_id_
        self.tile = tile_


func _ready() -> void:
    self.game_state.init_cells(self.board_shape)
    self.game_grid.create_grid_cell_backgrounds(self.board_shape)


func create_tile(cell_id: Vector2, power: int) -> NumberTile:
    var tile: NumberTile = (NumberTileScene.instantiate() as NumberTile)
    tile.update_power(power)

    self.game_state.set_board_cell(cell_id, tile)
    self.game_grid.place_tile(cell_id, tile)
    self.add_child(tile)

    return tile


func get_tile(cell_id: Vector2) -> TileRef:  # TileRef | null
    var tile = self.game_state.get_board_cell(cell_id)
    return TileRef.new(cell_id, tile)


func delete_tile(ref: TileRef) -> void:
    self.game_state.clear_board_cell(ref.cell_id)
    ref.tile.queue_free()


func move_tile(source_ref: TileRef, target_cell_id: Vector2) -> void:
    self.game_state.clear_board_cell(source_ref.cell_id)
    self.game_state.set_board_cell(target_cell_id, source_ref.tile)
    self.game_grid.place_tile(target_cell_id, source_ref.tile)


func merge_tiles(source_ref: TileRef, target_ref: TileRef) -> void:
    self.delete_tile(target_ref)
    self.move_tile(source_ref, target_ref.cell_id)
    source_ref.tile.increment_power()
