local position = ECS.Component(function(e ,x,y,z)
	e.pos = Vector3D(x,y,z or 0)
end)

return position
