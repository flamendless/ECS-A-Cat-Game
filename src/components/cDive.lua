local dive = ECS.Component(function(e, diveLength)
	e.dive = diveLength
	e.zVel = 0
end)

return dive
