local timer = ECS.Component(function(e, delay, callback, isEvery, count)
	e.delay = delay
	e.callback = callback or function() end
	e.timer = Timer.new()

	if isEvery then
		e.timer:every(e.delay, function()
			e.callback()
		end, count)
	else
		e.timer:after(e.delay, function()
			e.callback()
		end)
	end
end)

return timer
