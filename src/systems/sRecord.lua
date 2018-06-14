local record = ECS.System({COMPONENTS.record})

local isRecording = false
local isReplaying = false
local replay_paused = false
local save_record = false
local loop = true
local frame = 0
local max_frame = 0
local progress_style = {
	rcru = true,
	loading = false,
}
local bar = {
	x = CONST.game_size.x/2 - 64,
	y = 8,
	w = 128,
	h = 16
}
local data = {}

function record:update(dt)
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		if isRecording then
			self:updateRecord(dt)
		elseif isReplaying then
			if frame > max_frame then
				self:stopReplay()
				if loop then
					self:startReplay()
				end
			else
				self:updateReplay(dt)
			end
		end
	end
	if CONST.test then
		local status = ""
		if isRecording then status = "Recording"
		elseif isReplaying and not loop then status = "Replaying"
		elseif isReplaying and loop then status = "Replaying Loop:"
		end
		GAME.current:emit("addMSG", 1, {
				txt = ("%s %i/%i"):format(status,frame, max_frame),
				x = 2, y = 2
			})
	end
end

function record:draw()
	GAME.current:emit("register", "replay-gui-bar", function()
		if CONST.test then
			love.graphics.setColor(1,0,1,1)
			love.graphics.rectangle("fill", bar.x, bar.y, bar.w, bar.h)
			if max_frame > 0 and isReplaying then
				love.graphics.setColor(1,1,1,1)
				--like a loading bar
				if progress_style.loading then
					love.graphics.rectangle("fill", bar.x, bar.y, frame/max_frame * bar.w, bar.h)
				--like in Ransom City River Underground, debug mode shown by Andrew Russells
				elseif progress_style.rcru then
					local w = 4
					local x = (bar.x + frame/max_frame * bar.w) - w/2
					love.graphics.rectangle("fill", x, bar.y - 2, w, bar.h + 4)
				end
			end
		end
	end)
end

function record:updateRecord(dt)
	frame = frame + 1
	data[frame] = {}
end

function record:updateReplay(dt)
	if not replay_paused then
		frame = frame + 1
		self:replay()
	end
end

function record:replay(ev)
	if data[frame] then
		for _key, _state in pairs(data[frame]) do
			if _state then
				GAME.current:emit("replayKeys", _key, _state)
			end
		end
	end
end

function record:capture(key, state)
	if data[frame] and isRecording then
		--single key
		--data[frame].key = key
		--data[frame].state = state

		--multi-key
		if key == "r" then return end
		data[frame][key] = state
	end
end

local toSave = {
	"position",
	"jump"
}

function record:startRecord()
	isRecording = true
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local r = e:get(COMPONENTS.record)
		local save = {} --temporary table where to save data
		for _, comp in pairs(toSave) do --iterate through which components to save
			save[comp] = {} --create a sub table for the component name
			if e:has(COMPONENTS[comp]) then --check if the entity has that component
				local v = e:get(COMPONENTS[comp]) --get the actual component
				local temp --temp variable
				for _var, _val in pairs(v) do --iterate through each variable in the component
					if Vector3D.isVector(_val) then --check if that variable is of vector3D
						temp = Vector3D(_val.x, _val.y, _val.z) --copy the vector3D
					else
						temp = _val --just copy
					end
					save[comp][_var] = temp --save temp to the save table
				end
			end
			r.data = save --assign the record.data to the save table
		end
		--for k,v in pairs(r.data) do print(k,v) end --for checking
	end
end

function record:stopRecord()
	isRecording = false
	max_frame = frame
	frame = 0
	--save file?
	if save_record then
		UTILS.log("record.lua", data)
	end
end

function record:startReplay()
	isReplaying = true
	frame = 0
	local e
	for i = 1, self.pool.size do
		e = self.pool:get(i)
		local r = e:get(COMPONENTS.record)
		if r.data then --check if this exists
			for comp, t in pairs(r.data) do --iterate: component name, table
				if e:has(COMPONENTS[comp]) then --check if entity has that component
					local v = e:get(COMPONENTS[comp]) --get the actual component
					local temp
					for _var, _val in pairs(t) do --iterate: variable name and value
						--Apparently, we have to copy the data as well because for unknown reason, the record
						--data gets modified, some dog force probably causing stuffs to mess up :/
						if Vector3D.isVector(_val) then
							temp = Vector3D(_val.x, _val.y, _val.z)
						else
							temp = _val
						end
						v[_var] = temp --replace
					end
				end
			end
		end
	end
end

function record:stopReplay()
	isReplaying = false
	frame = 0
end

function record:pauseReplay()
	replay_paused = not replay_paused
end

function record:manager(todo)
	if todo == "record" then
		if isRecording == false and not isReplaying then
			self:startRecord()
		elseif isRecording then
			self:stopRecord()
		elseif isReplaying then
			self:stopReplay()
		end
	elseif todo == "replay" then
		if isReplaying == false then
			self:startReplay()
		else
			self:pauseReplay()
		end
	elseif todo == "nextFrame" then
		if replay_paused then
			frame = frame + 1
			self:replay()
		end
	elseif todo == "previousFrame" then
		if replay_paused then
			frame = frame - 1
			self:replay()
		end
	end
end

return record