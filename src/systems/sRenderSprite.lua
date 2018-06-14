local render_sprite = ECS.System({COMPONENTS.sprite, COMPONENTS.position})

function render_sprite:draw()
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local sprite = e:get(COMPONENTS.sprite).sprite
		local pos = e:get(COMPONENTS.position).pos
		local color = {1,0,0,1}
		local z = 0
		if e:has(COMPONENTS.color).color then
			color = e:get(COMPONENTS.color).color
		end
		if e:has(COMPONENTS.depth) then
			z = e:get(COMPONENTS.depth).z
		end
		RENDERER:queue(z, function()
			love.graphics.setColor(color)
			love.graphics.draw(sprite, pos.x, pos.y)
		end)
	end
end

return render_sprite
