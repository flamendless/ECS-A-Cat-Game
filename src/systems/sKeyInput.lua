local key_input = ECS.System({COMPONENTS.key_input}, {"replay", COMPONENTS.record})

function key_input:update(dt)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local inputs = e:get(COMPONENTS.key_input).inputs
		for key, func in pairs(inputs.down) do
			if love.keyboard.isDown(key) then
				GAME.current:emit("capture", key, true)
				func()
			end
		end
	end
end

function key_input:replayKeys(key, state)
	local e
	for i = 1, self.replay.size do
		e = self.pool:get(i)
		local inputs = e:get(COMPONENTS.key_input).inputs
		for _, t in pairs(inputs) do
			for _key, func in pairs(t) do
				if _key == key and state then
					func()
				end
			end
		end
	end
end

function key_input:keypressed(key)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local inputs = e:get(COMPONENTS.key_input).inputs
		GAME.current:emit("capture", key, true)
		for k, v in pairs(inputs.keypressed) do
			if key == k then
				v()
			end
		end
	end
end

function key_input:keyreleased(key)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local inputs = e:get(COMPONENTS.key_input).inputs
		GAME.current:emit("capture", key, false)
		for k, v in pairs(inputs.keyreleased) do
			if key == k then
				v()
			end
		end
	end
end

return key_input
