local color = ECS.Component(function(e, color)
	e.color = color or {1,1,1,1}
end)

return color
