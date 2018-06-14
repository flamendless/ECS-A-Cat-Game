local render_text = ECS.System({COMPONENTS.position, COMPONENTS.text})

function render_text:entityAdded(e)
	if e:has(COMPONENTS.size) then
		local size = e:get(COMPONENTS.size).size
		local text = e:get(COMPONENTS.text).text
		local font = e:get(COMPONENTS.text).font
		size.x = font:getWidth(text)
		size.y = font:getHeight(text)
	end
end

function render_text:draw()
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local pos = e:get(COMPONENTS.position).pos
		local text = e:get(COMPONENTS.text).text
		local font = e:get(COMPONENTS.text).font
		local color = {1,1,1,1}
		--local z = 0
		if e:has(COMPONENTS.color) then
			color = e:get(COMPONENTS.color).color
		end
		--if e:has(COMPONENTS.depth) then
			--z = e:get(COMPONENTS.depth).z
		--end
		--RENDERER:queue(z, function()
			love.graphics.setFont(font)
			love.graphics.setColor(color)
			love.graphics.print(text, pos.x, pos.y)
		--end)
	end
end

return render_text
