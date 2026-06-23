extends Entity

func loose_lives(amount: int) -> void:
	super(amount)
	player_damaged.emit(amount)
	
signal player_damaged(amount)
