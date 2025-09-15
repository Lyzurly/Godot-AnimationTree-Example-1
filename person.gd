extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree
var crouch_amount: float = 0.0
var jump_amount: float = 0.0

func _ready() -> void:
	print("test script")

func _input(_event: InputEvent) -> void:
	if jump_amount <= 0.:
		if Input.is_action_pressed("Jump"):
			var tween: Tween = create_tween()
			tween.tween_property(self,"crouch_amount",1.0,.4)
		if Input.is_action_just_released("Jump"):
			var tween: Tween = create_tween()
			tween.tween_property(self,"crouch_amount",0.,.4)
		
			var tween_jump: Tween = create_tween()
			tween_jump.tween_property(self,"jump_amount",crouch_amount,.2)
			tween_jump.finished.connect(_on_jump_up_finished)
		
func _on_jump_up_finished() -> void:
	var tween_jump: Tween = create_tween()
	tween_jump.tween_property(self,"jump_amount",0.,.2)

func _physics_process(_delta: float) -> void:
	animation_tree.set("parameters/Blend_Crouch/blend_amount", crouch_amount)
	
	animation_tree.set("parameters/Blend_Jump/blend_amount", jump_amount)
