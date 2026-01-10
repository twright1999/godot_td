extends Node2D

@export var starting_money := 500
@export var starting_health := 200
var dead = false

var money : int :
	set(value):
		money = value
		money_updated.emit(money)
		
var health : int :
	set(value):
		if value <= 0:
			health = 0
			# If health runs out and not already dead, emit game over and die
			if not dead:
				game_over.emit()
				GameEvents.auto_start = false
				dead = true
		else:
			health = value
		health_updated.emit(health)

const MIN_MONEY = 0

signal money_updated(new_money : int)
signal health_updated(new_health : int)
signal game_over()

func _ready() -> void:
	reset()

func add_money(money_to_add: int):
	money += money_to_add

func take_money(money_to_take: int) -> bool:
	if is_valid_transaction(money_to_take):
		money -= money_to_take
		return true
	
	return false
	
func reset_money():
	money = starting_money

func reset_health():
	health = starting_health
	dead = false

func reset():
	reset_money()
	reset_health()

func is_valid_transaction(money_to_take: int) -> bool:
	return (money - money_to_take) >= MIN_MONEY
	

func add_health(health_to_add: int):
	health += health_to_add

func take_health(health_to_take: int):
	health -= health_to_take
	return health <= 0
	
