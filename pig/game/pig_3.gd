extends Node2D

var role = "pig"

func setup():
	if role == "boar":
		print(name + " is the BOAR")
	else:
		print(name + " is a pig")
