local move_speed = ECS.Component(function(e, speed)
	e.hspeed = speed
	e.vspeed = speed
end)

return move_speed
