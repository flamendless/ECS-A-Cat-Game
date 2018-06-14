local direction = ECS.Component(function(e, hdir, vdir)
	e.hdir = hdir or 0
	e.vdir = vdir or 0
end)

return direction
