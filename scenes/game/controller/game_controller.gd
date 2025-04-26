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


func shift_row(direction: Vector2i, row_index: int) -> bool:
    # only one coordinate will be changing
    var movement_axis: int = direction.abs().max_axis_index()
    # algorihm goes backwards, so direction is negated
    var cell_id_step: Vector2i = -direction

    var starting_cell_id: Vector2i = Vector2i.ZERO
    if cell_id_step < Vector2i.ZERO:
        # cell_id_step is negative, so we start from the end of the row
        starting_cell_id[movement_axis] = self.board_shape[movement_axis] - 1
    # the other axis is attached to row_id
    starting_cell_id[(movement_axis + 1) % 2] = row_index

    var target_cell_id: Vector2i = starting_cell_id
    var source_cell_id: Vector2i = starting_cell_id + cell_id_step

    var source_ref: TileRef
    var target_ref: TileRef

    var has_anything_moved: bool = false

    while (  # loops through the whole row
        source_cell_id[movement_axis] >= 0
        and source_cell_id[movement_axis] < self.board_shape[movement_axis]
    ):
        source_ref = self.get_tile(source_cell_id)
        if source_ref == null:
            # can't move or merge an empty cell, move to the next source
            source_cell_id += cell_id_step
            continue

        target_ref = self.get_tile(target_cell_id)
        if target_ref == null:
            # can move source to an empty target cell, so do that
            self.move_tile(source_ref, target_cell_id)
            has_anything_moved = true
            # next time we'll try to merge the next source into the same target
            source_cell_id += cell_id_step
        elif source_ref.tile.power == target_ref.tile.power:
            # can merge source with target, so do that
            self.merge_tiles(source_ref, target_ref)
            has_anything_moved = true
            # two merges on the same cell are not allowed, go to the next target
            target_cell_id += cell_id_step
            # current source is now an empty cell, so move on to the next source
            source_cell_id += cell_id_step
        else:
            # move and merge are not possible, move on to the next target
            target_cell_id += cell_id_step
            if source_cell_id == target_cell_id:
                # source can't be the same as target
                source_cell_id += cell_id_step

    return has_anything_moved


func shift_board(direction: Vector2i) -> bool:
    var row_count_axis: int = direction.abs().min_axis_index()

    var has_anything_moved: bool = false
    for row_index in range(self.board_shape[row_count_axis]):
        if self.shift_row(direction, row_index):
            has_anything_moved = true
    return has_anything_moved


var chance_of_spawning_a_four: float = 0.1


func spawn_random_tile() -> void:
    var empty_cell_ids = self.game_state.list_empty_cell_ids()
    var cell_id = empty_cell_ids[randi_range(0, empty_cell_ids.size() - 1)]

    var tile_power = 2 if randf() < chance_of_spawning_a_four else 1

    self.create_tile(cell_id, tile_power)


func perform_game_move(direction: Vector2i) -> void:
    var has_anything_moved = self.shift_board(direction)

    if has_anything_moved:
        self.spawn_random_tile()
