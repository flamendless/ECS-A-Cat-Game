local utils = {}

function utils.table_count(t)
	local count = 0
	for k,v in pairs(t) do
		count = count + 1
	end
	return count
end

function utils.table_filter(t, filter)
	for k,v in pairs(t) do
		if v[filter] then
			return v[filter]
		end
	end
end

function utils.boolConvert(bool, t, f)
	if type(bool) == "boolean" then
		if bool == true then
			if t then return t
			else return 1
			end
		elseif bool == false then
			if f then return f
			else return 0
			end
		end
	elseif type(bool) == "number" then
		if bool == 1 then
			if t then return t
			else return true
			end
		elseif bool == 0 then
			if f then return f
			else return false
			end
		end
	end
end

function utils.log(filename, data)
	local log = Inspect(data)
	if love.filesystem.getInfo(filename) then
		love.filesystem.append(filename, log)
	else
		love.filesystem.write(filename, log)
		print(filename .. " is saved.")
	end
end

return utils
