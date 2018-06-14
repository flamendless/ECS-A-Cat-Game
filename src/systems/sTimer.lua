local timer = ECS.System({COMPONENTS.timer})

function timer:update(dt)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local timer = e:get(COMPONENTS.timer).timer
		timer:update(dt)
	end
end

return timer
