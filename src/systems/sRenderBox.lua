local render_box = ECS.System({COMPONENTS.position, COMPONENTS.size})

local getZSortedItems = require("modules.zsorted")

local setAlpha = function(item, a)
	local color = {1,0,0,1}
	if item:has(COMPONENTS.color) then
		color = item:get(COMPONENTS.color).color
	end
	love.graphics.setColor(color[1] * a, color[2] * a, color[3] * a)
end

function render_box:draw()
	self:drawShadow()
	for _, item in ipairs(getZSortedItems:call(GAME.world)) do
		self:drawItem(item)
	end
end

function render_box:drawShadow(item)
	local item
	for i = 1, self.pool.size do
		local item = self.pool:get(i)
		if item:has(COMPONENTS.shadow) then
  		local color = {1,1,1,1}
			if item:has(COMPONENTS.color) then
				color = item:get(COMPONENTS.color).color
			end
  		love.graphics.setColor(
    		color[1] * 0.15,
    		color[2] * 0.15,
    		color[3] * 0.15
  		)
			local x,y,z,w,h,d = GAME.world:getCube(item)
  		love.graphics.rectangle("fill", x, y, w, h)
  	end
  end
end

function render_box:drawItem(item)
	if item:has(COMPONENTS.visible) then
		if not item:get(COMPONENTS.visible).visible then return end
	end
	local x,y,z,w,h,d = GAME.world:getCube(item)
  -- Front Side
  setAlpha(item, 0.3)
  love.graphics.rectangle("fill", x, y + z + h, w, d)
  setAlpha(item, 1)
  love.graphics.rectangle("line", x, y + z + h, w, d)
  -- Top
  setAlpha(item, 0.5)
  love.graphics.rectangle("fill", x, y + z, w, h)
  setAlpha(item, 1)
  love.graphics.rectangle("line", x, y + z, w, h)
end

return render_box
