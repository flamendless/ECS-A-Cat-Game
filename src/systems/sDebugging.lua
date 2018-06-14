local debugging = ECS.System({COMPONENTS.position}, {"gui", COMPONENTS.gui})

local selected
local msg = {}

function debugging:log(str,e)
	local pos
	local id
	local size
	local text = str or ""
	if e then
		if e:has(COMPONENTS.id) then
			id = e:get(COMPONENTS.id).id
		end
		if e:has(COMPONENTS.position) then
			pos = e:get(COMPONENTS.position).pos
		end
		if e:has(COMPONENTS.size) then
			size = e:get(COMPONENTS.size).size
		end
	end
	print(text)
	if id then
		print("\tID: " .. id)
	end
	if pos then
		print("\tPOSITION: " .. (pos))
	end
	if size then
		print("\tSIZE: " .. (size))
	end
end

function debugging:select(x,y)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local pos = e:get(COMPONENTS.position).pos
		local size = Vector(0,0)
		local visible = true
		if e:has(COMPONENTS.visible) then
			visible = e:get(COMPONENTS.visible).bool
		end
		if e:has(COMPONENTS.size) then
			size = e:get(COMPONENTS.size).size
		end
		if x >= pos.x and x <= pos.x + size.x then
			if y >= pos.y + pos.z and y <= pos.y + pos.z + size.y or
				y >= pos.y and y <= pos.y + size.y then
				if visible then
					selected = e
					self:log("SELECTED: ", selected)
					break
				end
			end
		end
	end
end

local padding = 2
function debugging:draw()
	if selected then
		local pos = selected:get(COMPONENTS.position).pos
		local size = selected:get(COMPONENTS.size).size
		love.graphics.setColor(1,1,1,1)
		love.graphics.rectangle("line",
			pos.x, pos.y + pos.z + size.y,
			size.x, size.z)
		love.graphics.rectangle("line",
			pos.x, pos.y + pos.z,
			size.x, size.y)
	end
	self:drawDebug()
end

function debugging:mousepressed(x,y,mb)
	if mb == 1 then
		self:select(x,y)
	end
end

function debugging:mousereleased(x,y,mb)
	if mb == 2 then
		selected = nil
		self:log("DESELECTED: ")
	end
end

function debugging:keyreleased(key)
	if key == "p" then
		if selected then
			self:log("SELECTED: ", selected)
		end
	end
end

function debugging:drawDebug()
  local statistics = ("fps: %d, mem: %dKB, items: %d"):format(
    love.timer.getFPS(),
    collectgarbage("count"),
    GAME.world:countItems()
  )
  love.graphics.setColor(1,1,1)
  love.graphics.print(statistics, 2, CONST.game_size.y - 16)

  if msg then
  	for k,v in pairs(msg) do
  		love.graphics.setColor(1,1,1)
			love.graphics.print(v.txt, v.x, v.y)
  	end
  end
end

function debugging:addMSG(i,m)
	msg[i] = m
end

return debugging
