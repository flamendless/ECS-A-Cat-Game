local size = ECS.Component(function(e ,width,height,depth)
	e.w = width
	e.h = height
	e.depth = depth or 0

	e.size = Vector3D(e.w,e.h,e.depth)
end)

return size
