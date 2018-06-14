local grids = ECS.Component(function(e, w,h)
	e.width = w or 32
	e.height = h or 32
	e.cols = 0
	e.rows = 0
	e.data = {}
end)

return grids
