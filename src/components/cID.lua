local ID = ECS.Component(function(e, id)
	e.id = id or "no ID"
end)

return ID
