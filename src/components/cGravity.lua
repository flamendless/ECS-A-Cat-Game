local gravity = ECS.Component(function(e, grav)
	e.gravity = grav or 0
end)

return gravity
