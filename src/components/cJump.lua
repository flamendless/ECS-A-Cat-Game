local jump = ECS.Component(function(e, jumpHeight)
	e.zVel = 0
	e.jumpHeight = jumpHeight
end)

return jump
