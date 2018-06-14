local gui = ECS.System({COMPONENTS.gui})

local toDraw = {}

function gui:register(id, f)
	toDraw[id] = f
end

function gui:draw()
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
	end

	if toDraw then
		for k,v in pairs(toDraw) do v() end
	end
end

return gui
