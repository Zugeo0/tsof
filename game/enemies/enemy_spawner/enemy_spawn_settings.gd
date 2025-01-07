class_name EnemySpawnSettings extends Resource

## Enemy scene to spawn
@export var enemy: PackedScene

## Speed in seconds
@export var spawn_rate: Curve

## Time before enemies can spawn
@export var start_time: float = 0.0

## Amount of time enemies will spawn for (0 for unlimited)
@export var spawn_duration: float = 0.0

## The minimum amount of enemies that will be spawned at once
@export var min_group_size: int = 1

## The maximum amount of enemies that will be spawned at once
@export var max_group_size: int = 1

## The maximum amount of times enemies can be spawned (0 for unlimited)
@export var max_spawns: int = 0

## The minimum range the enemies will be spawned from the player
@export var min_spawn_range: float = 1000.0

## The maximum range the enemies will be spawned from the player
@export var max_spawn_range: float = 2000.0
