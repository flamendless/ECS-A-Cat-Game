local grids = ECS.System({COMPONENTS.grids})

function grids:entityAdded(e)
	local g = e:get(COMPONENTS.grids)
	local cols = math.floor(CONST.game_size.x / g.width)
	local rows = math.floor(CONST.game_size.y / g.height)

	local _grids = {}
	for x = 0, cols-1 do
		_grids[x] = {}
		for y = 0, rows-1 do
			_grids[x][y] = {x = x * g.width, y = y * g.height, w = g.width, h = g.height}
		end
	end
	g.data = _grids
end

function grids:draw()
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local grids = e:get(COMPONENTS.grids).data
		for k,v in pairs(grids) do
			for n,m in pairs(v) do
				love.graphics.setColor(1,0,0,1)
				love.graphics.rectangle("line", m.x,m.y,m.w,m.h)
			end
		end
	end
end

return grids
