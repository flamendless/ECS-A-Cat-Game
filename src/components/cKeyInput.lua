local key_input = ECS.Component(function(e, keys)
	e.inputs = {
		down = {},
		keypressed = {},
		keyreleased = {}
	}
	
	for state, t in pairs(keys) do
		for key, func in pairs(t) do
			e.inputs[state][key] = func
		end
	end
end)

return key_input
