extends Node

var scale = 0.5
var length_tot = 0.3*scale
var length = length_tot*(1.0/6.0)
var size = 40.0
var size_tot = length*size

func _ready():
	var edgel = piece()
	edgel.translation.x = -length*size/2+(length/2)
	edgel.mode = RigidBody.MODE_STATIC
	
	for i in size-2:
		var piece = piece()
		piece.translation.x = (-length*size/2)+(length/2)+(length*(i+1))
		piece.gravity_scale = 0
		attach_to(i+1)
		
	var edger = piece()
	edger.translation.x = (length*size/2)-(length/2)
	edger.mode = RigidBody.MODE_STATIC
	attach_to(size-1)
	
	var stone = piece()
	stone.translation.y += 1
	stone.gravity_scale = 0.5
	stone.collision_layer = 1

func attach_to(number):
	var pieces = get_tree().get_nodes_in_group("RopePieces")
	var last = pieces[number-1]
	var this = pieces[number]
	var joint = ConeTwistJoint.new()
	joint.translation = last.translation 
	joint.translation.x += length/2.0
	joint.twist_span = 0
	joint.swing_span = 0
	#joint.bias = 10
	#joint.relaxation = 2
	joint.set_node_a(last.get_path())
	joint.set_node_b(this.get_path())
	add_child(joint)
	
func piece():
	var piece = preload("res://RopePiece.tscn").instance()
	add_child(piece)
	return piece
