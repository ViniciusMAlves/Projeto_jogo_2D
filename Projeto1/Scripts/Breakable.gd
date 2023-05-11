extends CharacterBody2D

@export var coin_instance: Array[PackedScene]
@export_range(0, 20, 1) var cois = 0

var divX = 2
var divY = 2

func destroy():
	cois -= 1;
	if cois < 0 :
		var region = $texture.region_rect
		var texture = $texture.texture
		var sizeX = region.size.x / divX
		var sizeY = region.size.y / divY
		
		for h in range(divY):
			for w in range(divX):
				var rect = Rect2(region.position.x + (sizeX * w),region.position.y + (sizeY * h), sizeX, sizeY)
				var sprite= Sprite2D.new()
				sprite.texture = texture
				sprite.region_enabled = true
				sprite.region_rect = rect
				sprite.centered = false
				sprite.global_position = $texture.global_position
				
				var rigid = RigidBody2D.new()
				rigid.add_child(sprite)
				get_parent().add_child(rigid)
				rigid.apply_impulse(Vector2(randf_range(-100,100),randf_range(-300,-350)), Vector2.ZERO)
		queue_free()
	else:
		create_coin()
		$anim.play("hit")
		
func create_coin():
	var coin_number = round(randf_range(0, coin_instance.size()-1))
	var coin = coin_instance[coin_number].instantiate()
	coin.global_position = $spawnPoint.global_position
	coin.apply_impulse(Vector2(randf_range(-30,30), -80), Vector2.ZERO)
	get_parent().call_deferred("add_child", coin)
