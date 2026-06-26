extends Node
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func death_noise():
	animation_player.play("Death Sound")

var alive: bool = true
