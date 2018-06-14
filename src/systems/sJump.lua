local jump = ECS.System({COMPONENTS.jump})

function jump:jump()
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local j = e:get(COMPONENTS.jump)
		local onFloor = j.zVel == 0
		if onFloor then
			j.zVel = -j.jumpHeight
		end
	end
end

return jump
