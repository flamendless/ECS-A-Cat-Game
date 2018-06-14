local text = ECS.Component(function(e, text, font)
	e.text = text
	if type(font) == "number" then
		e.font_size = font
	end
	e.font = love.graphics.newFont(e.font_size)
	if CONST.isPixel then
		e.font:setFilter("nearest", "nearest", 1)
	end
end)

return text
