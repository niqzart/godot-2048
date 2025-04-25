extends Node2D
class_name GameController

@export var NumberTileScene: PackedScene

@onready var game_state: GameState = $GameState
@onready var game_grid: GameGrid = $GameGrid

var board_shape: Vector2i = Vector2i(4, 4)


class TileRef:
    var cell_id: Vector2i
    var tile: NumberTile

    func _init(cell_id_: Vector2i, tile_: NumberTile) -> void:
        self.cell_id = cell_id_
        self.tile = tile_


func _ready() -> void:
    self.game_state.init_cells(self.board_shape)
    self.game_grid.create_grid_cell_backgrounds(self.board_shape)


func create_tile(cell_id: Vector2i, power: int) -> NumberTile:
    var tile: NumberTile = (NumberTileScene.instantiate() as NumberTile)
    tile.update_power(power)

    self.game_state.set_board_cell(cell_id, tile)
    self.game_grid.place_tile(cell_id, tile)
    self.add_child(tile)

    return tile


func get_tile(cell_id: Vector2i) -> TileRef:  # TileRef | null
    var tile = self.game_state.get_board_cell(cell_id)
    if tile == null:
        return null
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


func shift_row(start_cell_id: Vector2i, cell_id_step: Vector2i) -> void:
    var target_cell_id = start_cell_id
    var source_cell_id = start_cell_id + cell_id_step

    var source_ref: TileRef
    var target_ref: TileRef

    while (
        source_cell_id.x >= 0
        and source_cell_id.y >= 0
        and source_cell_id.x < self.board_shape.x
        and source_cell_id.y < self.board_shape.y
    ):
        source_ref = self.get_tile(source_cell_id)
        if source_ref == null:
            source_cell_id += cell_id_step
            continue

        target_ref = self.get_tile(target_cell_id)
        if target_ref == null:
            self.move_tile(source_ref, target_cell_id)
            source_cell_id += cell_id_step
        elif source_ref.tile.power == target_ref.tile.power:
            self.merge_tiles(source_ref, target_ref)
            target_cell_id += cell_id_step
            source_cell_id += cell_id_step
        else:
            target_cell_id += cell_id_step
            if source_cell_id == target_cell_id:
                source_cell_id += cell_id_step
