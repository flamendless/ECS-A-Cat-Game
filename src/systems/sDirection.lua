local dir = ECS.System({COMPONENTS.direction})

function dir:update(dt)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local d = e:get(COMPONENTS.direction)
		d.hdir = 0
		d.vdir = 0
	end
end

function dir:change_dir(hor, ver)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local d = e:get(COMPONENTS.direction)
		--will not allow diagonal
		--d.hdir = hor or 0
		--d.vdir = ver or 0
		
		--allow diagonal
		if hor then d.hdir = hor end
		if ver then d.vdir = ver end
	end
end

return dir
