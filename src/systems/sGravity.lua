local gravity = ECS.System({COMPONENTS.position, COMPONENTS.gravity})

function gravity:update(dt)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local pos = e:get(COMPONENTS.position).pos
		local grav = e:get(COMPONENTS.gravity).gravity

		pos.y = pos.y + grav * dt
	end
end

return gravity
