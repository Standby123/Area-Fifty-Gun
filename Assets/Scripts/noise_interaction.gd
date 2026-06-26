extends Area2D

@onready var clang_player: AnimationPlayer = $"Clang Player"

var glass_num: int = 1
var metal_num: int = 1


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Glass"):
		var glass: String = "Glass" + str(glass_num)
		clang_player.play(glass)
		glass_num += 1
		if glass_num > 3:
			glass_num = 1
			
	else:
		var metal: String = "Metal" + str(metal_num)
		clang_player.play(metal)
		metal_num += 1
		if metal_num > 6:
			metal_num = 1
