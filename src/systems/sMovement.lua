local movement = ECS.System({COMPONENTS.position, COMPONENTS.move_speed, COMPONENTS.direction}, {COMPONENTS.position, COMPONENTS.jump, "jump"})

function movement:update(dt)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local pos = e:get(COMPONENTS.position).pos
		local speed = e:get(COMPONENTS.move_speed)
		local direction = e:get(COMPONENTS.direction)

		--check
		local left = -UTILS.boolConvert(direction.hdir == -1)
		local right = UTILS.boolConvert(direction.hdir == 1)
		local up = -UTILS.boolConvert(direction.vdir == -1)
		local down = UTILS.boolConvert(direction.vdir == 1)

		local dx, dy = 0, 0
		dx = speed.hspeed * (left + right) * dt
		dy = speed.vspeed * (up + down) * dt
		
		if dx ~= 0 or dy ~= 0 or speed.zVel ~= 0 then
    	local cols
			pos.x, pos.y, pos.z, cols, collisions = GAME.world:move(e, pos.x + dx, pos.y + dy, pos.z)
		end
	end

	--FOR JUMPING
	for i = 1, self.jump.size do
		e = self.jump:get(i)
		local pos = e:get(COMPONENTS.position).pos
		local jump = e:get(COMPONENTS.jump)
		jump.zVel = jump.zVel + CONST.gravity * dt
		if jump.zVel ~= 0 then
    	local cols
			pos.x, pos.y, pos.z, cols, collisions = GAME.world:move(e, pos.x, pos.y, pos.z + jump.zVel * dt)
			for i = 1, collisions do
				local col = cols[i]
				if col.normal.z ~= 0 then jump.zVel = 0 end
			end
		end
	end
end

return movement
