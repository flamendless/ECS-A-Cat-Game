local logic = {}

function logic.moveHorizontal(d)
	return function()
		GAME.current:emit("change_dir", d, nil)
	end
end

function logic.moveVertical(d)
	return function()
		GAME.current:emit("change_dir", nil, d)
	end
end

function logic.jump()
	return function()
		GAME.current:emit("jump")
	end
end

return logic
