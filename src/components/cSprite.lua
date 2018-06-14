local sprite = ECS.Component(function(e, texture, rot, sx, sy)
	e.texture = texture
	e.rot = rot or 0
	e.sx = sx or 1
	e.sy = sy or 1
end)

return sprite
