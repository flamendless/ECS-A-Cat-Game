local depth = ECS.Component(function(e, depth)
	e.depth = depth or 0
end)

return depth
